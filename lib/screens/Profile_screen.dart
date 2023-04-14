import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_meet/variables.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';
import 'package:share/share.dart';
import 'navigate_auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  bool _dataisThere = false;
  TextEditingController _usernameUpdate = TextEditingController();

  final oneplus_rive = 'assets/oneplus_loader.riv';
  Artboard _artboard;

  @override
  void initState() {
    getUserData();
    _loadRiveFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load(oneplus_rive);
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController(SimpleAnimation('First')));
    }
  }

  getUserData() async {
    DocumentSnapshot userdoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      _username = userdoc.data()['username'];
      _dataisThere = true;
    });
  }

  editProfile() async {
    userCollection.doc(FirebaseAuth.instance.currentUser.uid).update({
      'username': _usernameUpdate.text,
    });
    setState(() {
      _usernameUpdate.text.isEmpty
          ? _username = "Update Your Name"
          : _username = _usernameUpdate.text;
    });
    Navigator.pop(context);
  }

  showUpdateProfileDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25, bottom: 45, left: 35, right: 35),
              child: Container(
                color: Colors.grey.shade800,
                height: 150,
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameUpdate,
                      style: whiteStyle(20),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Enter new name',
                          labelStyle: whiteStyle(15)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: MaterialButton(
                        minWidth: 100,
                        color: myRed.withOpacity(1),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          editProfile();
                        },
                        child: Text(
                          'Update',
                          style: whiteStyle(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade800,
      body: _dataisThere == false
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: myRed,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 20,
                            bottom: MediaQuery.of(context).size.height / 55),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                            ),
                          ], borderRadius: BorderRadius.circular(55)),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: AvatarLetter(
                                text: _username,
                                numberLetters: 2,
                                upperCase: true,
                                fontSize: 35,
                                textColor: myRed,
                                backgroundColor: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        _username,
                        style: whiteStyle(25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: MaterialButton(
                              minWidth: 100,
                              color: myRed.withOpacity(0.4),
                              onPressed: () {
                                showUpdateProfileDialog();
                              },
                              child: Text(
                                'Edit Profile',
                                style: whiteStyle(15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25, left: 10),
                            child: MaterialButton(
                              splashColor: Colors.red,
                              minWidth: 100,
                              color: myRed.withOpacity(0.4),
                              onPressed: () {
                                setState(() {
                                  _usernameUpdate.text.isEmpty
                                      ? _username = 'Update Your name'
                                      : _username = _usernameUpdate.text;
                                });
                                try {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: Navigate_Auth_Screen(),
                                          type: PageTransitionType.fade));
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                'Sign out',
                                style: whiteStyle(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            Share.share(
                                'Hey Checkout, New Meeting App. https://play.google.com/store/apps/details?id=lets.meet.video');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Share App',
                                  style: whiteStyle(15),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child:
                              Rive(artboard: _artboard, fit: BoxFit.contain)),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 100),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'images/Logo512.png',
                                height: 50,
                              ),
                              Text(
                                'Designed & Developed by',
                                style: whiteStyle(15),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3, bottom: 30),
                                child: Text(
                                  'Dixit',
                                  style: extraHeavyStyle(Colors.white, 18),
                                ),
                              ),
                              Text(
                                'Copyright © 2020 Dixit,Inc. All Rights reserved.',
                                style: extraHeavyStyle(Colors.white, 10),
                              ),
                              Text(
                                'V 0.0.1',
                                style: extraHeavyStyle(Colors.white, 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
