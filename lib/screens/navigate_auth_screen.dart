import 'package:flutter/material.dart';
import 'package:lets_meet/screens/login_screen.dart';
import 'package:lets_meet/screens/reg_screen.dart';
import 'package:lets_meet/variables.dart';
import 'package:page_transition/page_transition.dart';

class Navigate_Auth_Screen extends StatefulWidget {
  @override
  _Navigate_Auth_ScreenState createState() => _Navigate_Auth_ScreenState();
}

class _Navigate_Auth_ScreenState extends State<Navigate_Auth_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade800,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 45),
                  child: Hero(
                    child: Image.asset(
                      'images/Logo512.png',
                      height: 200,
                    ),
                    tag: 'Logo',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: Login_Screen(), type: PageTransitionType.fade),
                    );
                  },
                  child: Hero(
                    tag: 'SignInTag',
                    child: Container(
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: blackStyle(20),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                        context,
                        PageTransition(
                            child: Registration_Screen(),
                            type: PageTransitionType.fade));
                  },
                  child: Hero(
                    tag: 'SignUpTag',
                    child: Container(
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: blackStyle(20),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
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
