import 'package:flutter/material.dart';
import 'package:lets_meet/variables.dart';
import 'package:lets_meet/videoconf/create_meeting.dart';
import 'package:lets_meet/videoconf/join_meeting.dart';

class VideoConference extends StatefulWidget {
  @override
  _VideoConferenceState createState() => _VideoConferenceState();
}

class _VideoConferenceState extends State<VideoConference>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  buildTab(String s) {
    return Container(
      height: 50,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Center(
          child: Text(
            s,
            style: whiteStyle(16),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.grey.shade800,
          title: Text(
            'Lets Meet',
            style: titleStyle(Colors.white, 20),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: myRed,
            tabs: [
              buildTab("Join Meeting"),
              buildTab("Create Meeting"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [Join_Meeting(), Create_Meeting()],
        ),
      ),
    );
  }
}
