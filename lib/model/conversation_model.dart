import 'package:bookinghotel/model/app_constants.dart';
import 'package:bookinghotel/model/contact_model.dart';
import 'package:bookinghotel/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  String? id;
  ContactModel? otherContact;
  List<MessageModel>? messages;
  MessageModel? lastMessage;

  ConversationModel() {
    messages = [];
  }

  addConversationToFirestore(ContactModel otherContact) async {
    List<String> userNames = [
      AppConstants.currentUser.getFullNameOfUser(),
      otherContact.getFullNameOfUser(),
    ];

    List<String> userIDs = [
      AppConstants.currentUser.id!,
      otherContact.id!,
    ];
    Map<String, dynamic> conversationDataMap = {
      'lastMessageDateTime': DateTime.now(),
      'lastMessageText': "",
      'userNames': userNames,
      'userIDs': userIDs,
    };
    DocumentReference reference = await FirebaseFirestore.instance
        .collection('conversations')
        .add(conversationDataMap);
    id = reference.id;
  }

  addMessageToFirestore(String messageText) async {
    Map<String, dynamic> messageData = {
      'dataTime': DateTime.now(),
      'senderID': AppConstants.currentUser.id,
      'text': messageText
    };

    await FirebaseFirestore.instance
        .collection('conversations/${id}/messages')
        .add(messageData);

    Map<String, dynamic> conversationData = {
      'lastMessageDateTime': DateTime.now(),
      'lastMessageText': messageText
    };
    await FirebaseFirestore.instance
        .doc('converstations/${id}')
        .update(conversationData);
  }
}
