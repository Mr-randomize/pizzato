import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userUid;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString('uid');
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
              child: userUid == null ? Login() : HomeScreen(),
              type: PageTransitionType.leftToRightWithFade),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    color: Colors.black,
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
                        color: Colors.black,
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
