import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Headers extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
            icon: Icon(EvaIcons.logOut),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('uid');
              Navigator.pushReplacement(
                context,
                PageTransition(
                    child: Login(), type: PageTransitionType.leftToRight),
              );
            }),
      ],
      centerTitle: true,
      title: Text(
        'Home',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
      ),
    );
  }

  Widget headerText() {
    return Container(
      constraints: BoxConstraints(maxWidth: 250.0),
      child: RichText(
        text: TextSpan(
            text: 'What would you like ',
            style: TextStyle(
              fontSize: 29.0,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'to eat?',
                style: TextStyle(
                  fontSize: 46.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.greenAccent,
                ),
              ),
            ]),
      ),
    );
  }

  Widget headerMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.redAccent, blurRadius: 4.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.grey.shade100),
              height: 40.0,
              width: 100,
              child: Center(
                child: Text(
                  'All Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlueAccent, blurRadius: 4.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.lightBlue.shade100),
              height: 40.0,
              width: 100,
              child: Center(
                child: Text(
                  'Pizza',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.greenAccent, blurRadius: 4.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.greenAccent.shade100),
              height: 40.0,
              width: 100,
              child: Center(
                child: Text(
                  'Pasta',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
