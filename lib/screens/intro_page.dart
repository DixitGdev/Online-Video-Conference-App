import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lets_meet/screens/navigate_auth_screen.dart';
import 'package:lets_meet/variables.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro_Page extends StatefulWidget {
  @override
  _Intro_PageState createState() => _Intro_PageState();
}

class _Intro_PageState extends State<Intro_Page>
    with AfterLayoutMixin<Intro_Page> {
  Future checkFirstTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool _seen = (pref.getBool('seen') ?? false);

    if (_seen) {
      Navigator.push(
          context,
          PageTransition(
              child: Navigate_Auth_Screen(), type: PageTransitionType.fade));
    } else {
      await pref.setBool('seen', true);
      Navigator.push(context,
          PageTransition(child: Intro_Page(), type: PageTransitionType.fade));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    checkFirstTime();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Let's Meet",
          body: "Welcome to new Experience of Conference",
          image: Center(
            child: Image.asset(
              'images/first.png',
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          footer: Text(
            'Made in India  🇮🇳',
            style: whiteStyle(15),
          ),
          decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 150),
              titlePadding: EdgeInsets.only(top: 10),
              descriptionPadding: EdgeInsets.only(top: 20),
              bodyTextStyle: myStyle(18, Colors.white),
              titleTextStyle: myStyle(30, Colors.white),
              footerPadding: EdgeInsets.only(top: 30)),
        ),
        PageViewModel(
          title: "High Quality Video",
          body: "Seamless HD Video and Audio Streaming Conference",
          image: SvgPicture.asset(
            'images/third.svg',
            fit: BoxFit.contain,
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 120),
            titlePadding: EdgeInsets.only(top: 10),
            descriptionPadding: EdgeInsets.only(top: 20),
            bodyTextStyle: myStyle(18, Colors.white),
            titleTextStyle: myStyle(30, Colors.white),
          ),
        ),
        PageViewModel(
          title: "Start New Experience",
          body: "Feature rich and Great User Experience",
          image: Center(
            child: SvgPicture.asset(
              'images/second.svg',
              fit: BoxFit.contain,
            ),
          ),
          decoration: PageDecoration(
            imagePadding: EdgeInsets.only(top: 120),
            titlePadding: EdgeInsets.only(top: 10),
            descriptionPadding: EdgeInsets.only(top: 20),
            bodyTextStyle: myStyle(18, Colors.white),
            titleTextStyle: myStyle(30, Colors.white),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(
            context,
            PageTransition(
                child: Navigate_Auth_Screen(), type: PageTransitionType.fade));
      },
      showSkipButton: false,
      skip: Text(
        'Skip',
        style: whiteStyle(15),
      ),
      next: Icon(
        Icons.navigate_next,
        color: Colors.white,
      ),
      showNextButton: true,
      done: Text(
        'Done',
        style: whiteStyle(15),
      ),
      globalBackgroundColor: Colors.grey.shade800,
      dotsDecorator: DotsDecorator(
        activeColor: Color(0xffe8505b),
        color: Colors.white,
      ),
      animationDuration: 600,
      curve: Curves.linearToEaseOut,
    );
  }
}
