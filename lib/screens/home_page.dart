import 'package:flutter/material.dart';
import 'package:lets_meet/screens/video_conference_screen.dart';
import 'package:lets_meet/variables.dart';
import 'Profile_screen.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int page = 0;
  List pageOptions = [VideoConference(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade700,
        selectedItemColor: Colors.white,
        selectedLabelStyle: whiteStyle(18),
        unselectedLabelStyle: whiteStyle(18),
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.video_call)),
          BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person)),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
      body: pageOptions[page],
    );
  }
}
