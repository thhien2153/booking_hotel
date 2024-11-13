import 'package:bookinghotel/model/booking_model.dart';
import 'package:bookinghotel/model/contact_model.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:bookinghotel/model/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ContactModel {
  String? email;
  String? password;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurrentlyHosting;
  DocumentSnapshot? snapshot;

  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;

  List<PostingModel>? myPostings;

  UserModel({
    String super.id,
    String super.firstName,
    String super.lastName,
    super.displayImage,
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
  }) {
    isHost = false;
    isCurrentlyHosting = false;

    bookings = [];
    reviews = [];

    myPostings = [];
  }

  addPostingToMyPostings(PostingModel posting) async {
    myPostings!.add(posting);

    List<String> myPostingIDsList = [];

    for (var element in myPostings!) {
      myPostingIDsList.add(element.id!);
    }

    await FirebaseFirestore.instance.collection("users").doc(id).update({
      'myPostingIDs': myPostingIDsList,
    });
  }

  getMyPostingsFromFirestore() async {
    List<String> myPostingIDs =
        List<String>.from(snapshot!["myPostingIDs"]) ?? [];

    for (String postingID in myPostingIDs) {
      PostingModel posting = PostingModel(id: postingID);
      await posting.getPostingInfoFromFirestore();
      await posting.getAllImagesFromStorage();

      myPostings!.add(posting);
    }
  }
}
