import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Headers extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(icon: Icon(FontAwesomeIcons.userAlt), onPressed: () {}),
          Row(
            children: [
              Icon(FontAwesomeIcons.locationArrow, color: Colors.grey.shade600),
              Text(
                'New Police Area',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
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
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'to eat?',
                style: TextStyle(
                  fontSize: 46.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
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
                    BoxShadow(color: Colors.redAccent, blurRadius: 15.0)
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
                    BoxShadow(color: Colors.lightBlueAccent, blurRadius: 15.0)
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
                    BoxShadow(color: Colors.greenAccent, blurRadius: 15.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.greenAccent.shade100),
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
          )
        ],
      ),
    );
  }
}
