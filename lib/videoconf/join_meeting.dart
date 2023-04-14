import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:lets_meet/variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class Join_Meeting extends StatefulWidget {
  @override
  _Join_MeetingState createState() => _Join_MeetingState();
}

class _Join_MeetingState extends State<Join_Meeting> {
  bool _isVideoMuted = true;
  bool _isAudioMuted = true;
  String _username = '';
  TextEditingController _meetingCodeController = TextEditingController();

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      _username = userdoc.data()['username'];
    });
  }

  join_meeting_function() async {
    if (_meetingCodeController.text == '') {
      Toast.show("Enter Meeting code 🙄", context,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          duration: Toast.LENGTH_LONG);
    } else {
      try {
        Toast.show("Joining Please Wait 🚀", context,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            duration: Toast.LENGTH_LONG);

        Map<FeatureFlagEnum, bool> featureFlags = {
          FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        };
        if (Platform.isAndroid) {
          featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
        } else if (Platform.isIOS) {
          featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
        }

        var options = JitsiMeetingOptions()
          ..room = _meetingCodeController.text
          ..userDisplayName = _username
          ..audioMuted = _isAudioMuted
          ..videoMuted = _isVideoMuted
          ..featureFlags.addAll(featureFlags);

        await JitsiMeet.joinMeeting(options);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 35, bottom: 25),
              child: Text(
                'Enter Meeting Code',
                style: whiteStyle(15),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 45, right: 45, bottom: 25),
              width: MediaQuery.of(context).size.width,
              child: PinCodeTextField(
                controller: _meetingCodeController,
                appContext: context,
                length: 6,
                textStyle: titleStyle(Colors.white, 20),
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    inactiveColor: myRed,
                    activeColor: Colors.white,
                    selectedColor: Colors.white),
                animationDuration: Duration(milliseconds: 200),
                autoDisposeControllers: false,
                backgroundColor: Colors.grey.shade800,
                animationType: AnimationType.fade,
              ),
            ),
            CheckboxListTile(
              checkColor: Colors.white,
              activeColor: myRed,
              value: _isAudioMuted,
              onChanged: (value) {
                FocusScope.of(context).unfocus();
                value == true
                    ? Toast.show("Audio Muted 🔇", context,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        duration: Toast.LENGTH_LONG)
                    : Toast.show("Audio Unmuted", context,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        duration: Toast.LENGTH_LONG);
                setState(() {
                  _isAudioMuted = value;
                });
              },
              title: Text(
                'Mute Audio',
                style: whiteStyle(15),
              ),
              tristate: false,
            ),
            CheckboxListTile(
              checkColor: Colors.white,
              activeColor: myRed,
              value: _isVideoMuted,
              onChanged: (value) {
                FocusScope.of(context).unfocus();
                value == true
                    ? Toast.show("Camera Muted", context,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        duration: Toast.LENGTH_LONG)
                    : Toast.show("Camera Unmuted", context,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        duration: Toast.LENGTH_LONG);
                setState(() {
                  _isVideoMuted = value;
                });
              },
              title: Text(
                'Mute Video',
                style: whiteStyle(15),
              ),
              tristate: false,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                'You can change this settings in meeting',
                style: whiteStyle(12),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width / 7,
              width: MediaQuery.of(context).size.width / 1.2,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: myRed,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  join_meeting_function();
                },
                child: Text(
                  'Join Meeting',
                  style: titleStyle(Colors.white, 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
