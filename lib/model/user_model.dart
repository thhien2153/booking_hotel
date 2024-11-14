import 'package:bookinghotel/model/booking_model.dart';
import 'package:bookinghotel/model/contact_model.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:bookinghotel/model/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
  List<PostingModel>? savedPostings;
  List<PostingModel>? myPostings;

  String? role;

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

    savedPostings = [];
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

  addSavePosting(PostingModel posting) async {
    for (var savedPosting in savedPostings!) {
      if (savedPosting.id == posting.id) {
        return;
      }
    }

    savedPostings!.add(posting);

    List<String> savedPostingIDs = [];

    savedPostings!.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id!);
    });

    await FirebaseFirestore.instance.collection("user").doc(id).update({
      'savedPostingIDs': savedPostingIDs,
    });
    Get.snackbar("Marked as Favourite", "Saved to your Favourite List");
  }

  removeSavedPosting(PostingModel posting) async {
    for (int i = 0; i < savedPostings!.length; i++) {
      if (savedPostings![i].id == posting.id) {
        savedPostings!.removeAt(i);
        break;
      }
    }
    List<String> savedPostingIDs = [];

    savedPostings!.forEach((savedPosting) {
      savedPostingIDs.add(savedPosting.id!);
    });

    await FirebaseFirestore.instance.collection("user").doc(id).update({
      'savedPostingIDs': savedPostingIDs,
    });

    Get.snackbar("Listing Removed", "Listing removed from your Favourite List");
  }

  Future<void> addBookingToFirestore(BookingModel booking,
      double totalPriceForAllNights, String hostID) async {
    Map<String, dynamic> data = {
      'dates': booking.dates,
      'postingID': booking.posting!.id!,
    };
    await FirebaseFirestore.instance
        .doc('user/${id}/bookings/${booking.id}')
        .set(data);

    String earningOld = "";
    await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .get()
        .then((dataSnap) {
      earningOld = dataSnap["earnings"].toString();
    });

    await FirebaseFirestore.instance.collection("users").doc(id).update({
      "earnings": totalPriceForAllNights + int.parse(earningOld),
    });
    bookings!.add(booking);
  }
}
