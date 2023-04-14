import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_meet/screens/home_page.dart';
import 'package:lets_meet/screens/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey.shade800));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lets Meet',
      home: Navigation_Page(),
    );
  }
}

class Navigation_Page extends StatefulWidget {
  @override
  _Navigation_PageState createState() => _Navigation_PageState();
}

class _Navigation_PageState extends State<Navigation_Page> {
  bool isSigned = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        if (mounted) {
          setState(() {
            isSigned = true;
          });
        }
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? Intro_Page() : Home_Page(),
    );
  }
}
