import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Services/maps.dart';
import 'package:pizzato/Views/my_cart.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Provider.of<GenerateMaps>(context, listen: false).fetchMaps(),
          Positioned(
            top: 50.0,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: MyCart(), type: PageTransitionType.fade));
              },
            ),
          )
        ],
      ),
    );
  }
}
