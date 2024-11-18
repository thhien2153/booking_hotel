// import 'package:bookinghotel/model/conversation_model.dart';
// import 'package:flutter/material.dart';

// class ConversationListTileUi extends StatefulWidget {
//   ConversationModel? conversation;
//   ConversationListTileUi({
//     super.key,
//     this.conversation,
//   });

//   @override
//   State<ConversationListTileUi> createState() => _ConversationListTileUiState();
// }

// class _ConversationListTileUiState extends State<ConversationListTileUi> {
//   ConversationModel? conversation;

//   getImageOfOtherContact() {
//     conversation!.otherContact!.getImageFromStorage().whenComplete(() {
//       setState(() {});
//     });
//   }

//   void initState() {
//     super.initState();

//     conversation = widget.conversation;
//     getImageOfOtherContact();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: GestureDetector(
//         onTap: () {},
//         child: CircleAvatar(
//           backgroundImage: conversation!.otherContact!.displayImage,
//           radius: MediaQuery.of(context).size.width / 14.0,
//         ),
//       ),
//       title: Text(
//         conversation!.otherContact!.getFullNameOfUser(),
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 18.5,
//         ),
//       ),
//       subtitle: Text(
//         widget.conversation!.lastMessage!.text!,
//         overflow: TextOverflow.ellipsis,
//       ),
//       trailing: Text(
//         widget.conversation!.lastMessage!.getMessageDateTime(),
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }
