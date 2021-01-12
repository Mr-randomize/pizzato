import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/AdminPanel/Views/login_screen.dart';
import 'package:pizzato/Views/login.dart';

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    Color(0xFFFF6600),
                    Color(0xFFFCF82F),
                    Color(0xFFD3CD00),
                    Color(0xFFFF6600),
                  ]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/deciderbg.png'),
              ),
            ),
          ),
          Positioned(
            top: 80.0,
            left: 30.0,
            child: Container(
              height: 200.0,
              width: 400.0,
              child: RichText(
                text: TextSpan(
                    text: 'Select ',
                    style: TextStyle(
                        fontFamily: 'Monteserat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 46.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Your ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                      TextSpan(
                        text: 'Side',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 190.0,
            child: Container(
              width: 400.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Customer',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Login(),
                              type: PageTransitionType.rightToLeft));
                    },
                  ),
                  MaterialButton(
                    color: Colors.redAccent,
                    child: Text(
                      'Employer',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: AdminLogin(),
                              type: PageTransitionType.rightToLeft));
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 720.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: 400.0,
              constraints: BoxConstraints(maxHeight: 200.0),
              child: Column(
                children: [
                  Text(
                    "By continuing you agree Pizzato's Terms of ",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  Text(
                    "Services & Privacy Policy",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
