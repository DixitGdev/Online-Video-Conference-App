import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet/variables.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:clipboard/clipboard.dart';

class Create_Meeting extends StatefulWidget {
  @override
  _Create_MeetingState createState() => _Create_MeetingState();
}

class _Create_MeetingState extends State<Create_Meeting> {
  String code = '';

  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 35, bottom: 25),
              child: Text(
                'Create Code and Share with Friends',
                textAlign: TextAlign.center,
                style: whiteStyle(15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Code : ',
                  style: titleStyle(Colors.white, 25),
                ),
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(code).then((value) => Toast.show(
                        "Code Copied", context,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        duration: Toast.LENGTH_LONG));
                  },
                  child: Text(
                    code,
                    style: extraHeavyStyle(myRed, 28),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '(Click to Copy)',
                style: whiteStyle(12),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: MaterialButton(
                minWidth: 150,
                color: myRed.withOpacity(0.8),
                onPressed: () {
                  createCode();
                  // Toast.show('Click on Code to Copy', context);
                },
                child: Text(
                  'Create Code',
                  style: whiteStyle(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
