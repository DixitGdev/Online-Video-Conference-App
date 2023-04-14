import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import '../variables.dart';
import 'home_page.dart';

class Registration_Screen extends StatefulWidget {
  @override
  _Registration_ScreenState createState() => _Registration_ScreenState();
}

class _Registration_ScreenState extends State<Registration_Screen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _passwordValidated = false;
  bool _emailValidated = false;
  bool _usernameValidated = false;

  bool _isSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        resizeToAvoidBottomInset: false,
        body: Scrollbar(
          child: ListView(
            physics: BouncingScrollPhysics(),
            itemExtent: 1000,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
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
                        controller: _userNameController,
                        maxLines: 1,
                        cursorColor: myRed,
                        decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorText: _usernameValidated
                                ? 'Username Cant be Empty'
                                : null,
                            prefixIcon: Icon(
                              Icons.person,
                              color: myRed,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelText: 'Username',
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
                        controller: _emailController,
                        maxLines: 1,
                        cursorColor: myRed,
                        decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorText: _emailValidated ? "Fix the Email" : null,
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
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            errorText: _passwordValidated
                                ? "Password length should be more than 6"
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
                          if (_userNameController.text == "") {
                            setState(() {
                              _usernameValidated = true;
                              _emailController.text.isEmpty
                                  ? _emailValidated = true
                                  : _emailValidated = false;
                              _passwordController.text.isEmpty
                                  ? _passwordValidated = true
                                  : _passwordValidated = false;
                            });
                          } else {
                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then(
                                (signedUser) {
                                  userCollection.doc(signedUser.user.uid).set({
                                    'username': _userNameController.text,
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                    'uid': signedUser.user.uid,
                                  });
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: Home_Page(),
                                          type: PageTransitionType.fade));
                                },
                              ).catchError((e) => Toast.show(
                                      "All Fields Are Require", context,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      duration: Toast.LENGTH_LONG));
                              setState(() {
                                _emailController.text.isEmpty
                                    ? _emailValidated = true
                                    : _emailValidated = false;
                                _passwordController.text.isEmpty
                                    ? _passwordValidated = true
                                    : _passwordValidated = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          }
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
