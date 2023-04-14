import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_meet/screens/home_page.dart';
import 'package:lets_meet/variables.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _validatedPassword = false;
  bool _validatedEmail = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade800,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 50),
              child: Hero(
                tag: 'Logo',
                child: Image.asset(
                  'images/Logo512.png',
                  height: 200,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextField(
                controller: _emailController,
                maxLines: 1,
                cursorColor: myRed,
                decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _validatedEmail ? 'Fix the Email' : null,
                    prefixIcon: Icon(
                      Icons.email,
                      color: myRed,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
                style: whiteStyle(20),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                maxLines: 1,
                cursorColor: myRed,
                decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    errorText: _validatedPassword
                        ? 'Password length should more than 6'
                        : null,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: myRed,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    )),
                style: whiteStyle(20),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  try {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Home_Page(),
                              type: PageTransitionType.fade));
                    }).catchError((e) => Toast.show(
                            "All Fields Are Require", context,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            duration: Toast.LENGTH_LONG));
                    setState(() {
                      _passwordController.text.isEmpty
                          ? _validatedPassword = true
                          : _validatedPassword = false;

                      _emailController.text.isEmpty
                          ? _validatedEmail = true
                          : _validatedEmail = false;
                    });
                  } catch (e) {
                    print(e);
                  }
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
            ),
          ],
        ),
      ),
    );
  }
}
