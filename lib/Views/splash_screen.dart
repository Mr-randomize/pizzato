import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/login.dart';
import 'package:pizzato/decider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userUid, userEmail;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString('uid');
    userEmail = prefs.getString('userEmail');
    print(userUid);
  }

  @override
  void initState() {
    super.initState();
    getUid().whenComplete(() {
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          PageTransition(
              child: userUid == null ? Decider() : HomeScreen(),
              type: PageTransitionType.leftToRightWithFade),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.2,
                0.54,
                0.6,
                0.9,
              ],
              colors: [
                Color(0xFF200B4B),
                Color(0xFF201F22),
                Color(0xFF1A1031),
                Color(0xFF19181F),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('animation/slice.json'),
            ),
            RichText(
              text: TextSpan(
                  text: 'PIZ',
                  style: TextStyle(
                    fontSize: 56.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Z',
                      style: TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: 'ATO',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 56.0,
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
