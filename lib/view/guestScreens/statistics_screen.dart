import 'package:bookinghotel/model/app_constants.dart';
import 'package:bookinghotel/model/booking_model.dart';
import 'package:bookinghotel/model/posting_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  // int userCount = 0;
  int postingCount = 0;
  int bookingCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var userModel = AppConstants.currentUser;

    List<PostingModel> postings = await userModel.getPostings();
    List<BookingModel> bookings = await userModel.getBookings();

    setState(() {
      postingCount = postings.length;
      bookingCount = bookings.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard(
                    postingCount.toString(), "Postings", Colors.purple),
                _buildInfoCard(
                    bookingCount.toString(), "Bookings", Colors.blue),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularIndicator(
                    "Booking", bookingCount / 100.0, Colors.blue),
                _buildCircularIndicator(
                    "Posting", postingCount / 100.0, Colors.green),
              ],
            ),
            SizedBox(height: 20),
            _buildAnalyticsSection(),
            SizedBox(height: 20),
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.7), color]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.insert_chart, color: Colors.white, size: 32),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIndicator(String label, double percentage, Color color) {
    return Expanded(
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 8.0,
            percent: percentage,
            center: Text(
              "${(percentage * 100).round()}%",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            progressColor: color,
            backgroundColor: Colors.grey[300]!,
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAnalyticsItem("Views", "14", Colors.blue),
          _buildAnalyticsItem("New Members", "2", Colors.green),
          _buildAnalyticsItem("Avg Time", "250.1", Colors.purple),
          _buildAnalyticsItem("Total Visits", "7", Colors.orange),
        ],
      ),
    );
  }

  Widget _buildAnalyticsItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.black54, fontSize: 14)),
      ],
    );
  }

  Widget _buildBarChart() {
    List<double> data = [15.0, 8.0, 12.0, 10.0, 17.0, 5.0, 14.0];
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(data.length, (index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 150,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: data[index] * 10,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(days[index], style: TextStyle(color: Colors.black)),
          ],
        );
      }),
    );
  }
}
