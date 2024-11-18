import 'package:bookinghotel/view/guestScreens/account_screen.dart';
import 'package:bookinghotel/view/guestScreens/explore_screen.dart';
import 'package:bookinghotel/view/guestScreens/statistics_screen.dart';
import 'package:bookinghotel/view/guestScreens/saved_listings_screen.dart';
import 'package:bookinghotel/view/guestScreens/trips_screen.dart';
import 'package:bookinghotel/view/hostScreens/bookings_screen.dart';
import 'package:bookinghotel/view/hostScreens/my_postings_screen.dart';
import 'package:flutter/material.dart';

class HostHomeScreen extends StatefulWidget {
  int? index;
  HostHomeScreen({super.key, this.index});

  @override
  State<HostHomeScreen> createState() => _HostHomeScreenState();
}

class _HostHomeScreenState extends State<HostHomeScreen> {
  int selectedIndex = 0;

  final List<String> screenTitles = [
    'Bookings',
    'My Postings',
    'Statistics',
    'Profile',
  ];

  final List<Widget> screens = [
    const BookingsScreen(),
    const MyPostingsScreen(),
    const StatisticScreen(),
    const AccountScreen(),
  ];

  BottomNavigationBarItem customNavigationBarItem(
      int index, IconData iconData, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
      ),
      activeIcon: Icon(
        iconData,
        color: Colors.green,
      ),
      label: title,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedIndex = widget.index ?? 3;
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
          screenTitles[selectedIndex],
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          customNavigationBarItem(
              0, Icons.calendar_month_outlined, screenTitles[0]),
          customNavigationBarItem(1, Icons.home_outlined, screenTitles[1]),
          customNavigationBarItem(2, Icons.chat_outlined, screenTitles[2]),
          customNavigationBarItem(3, Icons.person_outlined, screenTitles[3]),
        ],
      ),
    );
  }
}
