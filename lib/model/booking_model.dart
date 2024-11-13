import 'package:bookinghotel/model/contact_model.dart';
import 'package:bookinghotel/model/posting_model.dart';

class BookingModel
{
  String id = "";
  PostingModel? posting;
  ContactModel? contact;
  List<DateTime>? dates;

  BookingModel();
}