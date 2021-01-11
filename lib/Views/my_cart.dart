import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Miniviews/map_view.dart';
import 'package:pizzato/Providers/calculations.dart';
import 'package:pizzato/Services/manage_data.dart';
import 'package:pizzato/Services/maps.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context),
            headerText(),
            cartData(),
            shippingDetails(context),
            billingData(),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: HomeScreen(),
                      type: PageTransitionType.rightToLeftWithFade),
                );
              }),
          IconButton(
              icon: Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
              ),
              onPressed: () async {
                Provider.of<ManageData>(context, listen: false)
                    .deleteData(context);
                Provider.of<Calculations>(context, listen: false).cartData = 0;
              }),
        ],
      ),
    );
  }

  Widget headerText() {
    return Column(
      children: [
        Text(
          'Your',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 300.0,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('myOrders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('animation.delivery.json'),
              );
            } else {
              return ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                  return Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            blurRadius: 5.0,
                            spreadRadius: 5,
                          )
                        ],
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white),
                    height: 200.0,
                    width: 400.0,
                    child: Row(
                      children: [
                        SizedBox(
                          child: Image.network(
                            documentSnapshot.data()['image'],
                            width: 200.0,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              documentSnapshot.data()['name'],
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'Price: ${documentSnapshot.data()['price'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 21.0,
                              ),
                            ),
                            Text(
                              'Onion: ${documentSnapshot.data()['onion'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Bacon: ${documentSnapshot.data()['bacon'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Cheese: ${documentSnapshot.data()['cheese'].toString()}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                              ),
                            ),
                            CircleAvatar(
                              child: Text(
                                documentSnapshot.data()['size'],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }

  Widget shippingDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 5.0,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          color: Colors.white),
      height: 130.0,
      width: 400.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.locationArrow),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 250.0),
                        child: Text(
                          Provider.of<GenerateMaps>(context, listen: true)
                              .getMainAddress,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Maps(),
                              type: PageTransitionType.bottomToTop));
                    }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(EvaIcons.clock),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 250.0),
                      child: Text("6PM - 7PM"),
                    ),
                  ),
                ],
              ),
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }

  Widget billingData() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500, blurRadius: 5, spreadRadius: 3),
        ], borderRadius: BorderRadius.circular(40.0), color: Colors.white),
        height: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      '300.00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Delivery Charges',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      '20.00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.dollarSign,
                        color: Colors.black,
                        size: 18,
                      ),
                      Text(
                        '320.00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            print(userUid);
          },
          child: Container(
            width: 200.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.red.shade500,
                borderRadius: BorderRadius.circular(50.0)),
            child: Center(
              child: Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
