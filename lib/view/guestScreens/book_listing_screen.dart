import 'dart:io';

import 'package:bookinghotel/global.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:bookinghotel/payment_gateway/payment_config.dart';
import 'package:bookinghotel/view/guest_home_screen.dart';
import 'package:bookinghotel/view/widgets/calender_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListingScreen extends StatefulWidget {
  final PostingModel? posting;
  final String? hostID;

  BookListingScreen({
    super.key,
    this.posting,
    this.hostID,
  });

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  PostingModel? posting;
  List<DateTime> bookedDates = [];
  List<DateTime> selectedDates = [];
  List<CalenderUI> calendarWidgets = [];
  double bookingPrice = 0.0;
  String paymentResult = "";

  @override
  void initState() {
    super.initState();
    posting = widget.posting;
    _localBookedDates();
  }

  _buildCalendarWidgets() {
    calendarWidgets.clear();
    for (int i = 0; i < 12; i++) {
      calendarWidgets.add(
        CalenderUI(
          monthIndex: i,
          bookedDates: bookedDates,
          selectDate: _selectDate,
          getSelectedDates: _getSelectedDates,
        ),
      );
    }
    setState(() {});
  }

  List<DateTime> _getSelectedDates() {
    return selectedDates;
  }

  _selectDate(DateTime date) {
    if (selectedDates.contains(date)) {
      selectedDates.remove(date);
    } else {
      selectedDates.add(date);
    }
    selectedDates.sort();
    setState(() {});
  }

  _localBookedDates() async {
    try {
      await posting!.getAllBookingsFromFirestore();
      bookedDates = posting!.getAllBookedDates();
      _buildCalendarWidgets();
    } catch (error) {
      print("Error fetching booked dates: $error");
    }
  }

  _makeBooking() async {
    if (selectedDates.isEmpty) return;

    try {
      await posting!.makeNewBooking(selectedDates, context, widget.hostID);
      Get.back();
    } catch (error) {
      print("Error making booking: $error");
    }
  }

  calculateAmountForOverAllStay() {
    if (selectedDates.isNotEmpty) {
      double totalPriceForAllNights =
          selectedDates.length * (posting!.price ?? 0);
      setState(() {
        bookingPrice = totalPriceForAllNights;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
        title: Text(
          "Book ${posting?.name ?? ''}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sun'),
                Text('Mon'),
                Text('Tues'),
                Text('Wed'),
                Text('Thurs'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: (calendarWidgets.isEmpty)
                  ? Container()
                  : PageView.builder(
                      itemCount: calendarWidgets.length,
                      itemBuilder: (context, index) {
                        return calendarWidgets[index];
                      },
                    ),
            ),
            bookingPrice == 0.0
                ? MaterialButton(
                    onPressed: calculateAmountForOverAllStay,
                    minWidth: double.infinity,
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.green,
                    child: const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
            paymentResult.isNotEmpty
                ? MaterialButton(
                    onPressed: () {
                      Get.to(GuestHomeScreen());
                    },
                    minWidth: double.infinity,
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.green,
                    child: const Text(
                      'Amount paid successfully',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
            bookingPrice == 0.0
                ? Container()
                : Platform.isIOS
                    ? ApplePayButton(
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultApplePay),
                        paymentItems: [
                          PaymentItem(
                            label: 'Booking Amount',
                            amount: bookingPrice.toString(),
                            status: PaymentItemStatus.final_price,
                          ),
                        ],
                        style: ApplePayButtonStyle.black,
                        width: double.infinity,
                        height: 50,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) {
                          setState(() {
                            paymentResult = result.toString();
                          });
                          _makeBooking();
                        },
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : GooglePayButton(
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultGooglePay),
                        paymentItems: [
                          PaymentItem(
                            label: 'Total Amount',
                            amount: bookingPrice.toString(),
                            status: PaymentItemStatus.final_price,
                          ),
                        ],
                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) {
                          setState(() {
                            paymentResult = result.toString();
                          });
                          _makeBooking();
                        },
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
