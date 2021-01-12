import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Providers/calculations.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/my_cart.dart';
import 'package:provider/provider.dart';

class DetailedScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;

  DetailedScreen({this.queryDocumentSnapshot});

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  int totalItems = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(),
      backgroundColor: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(context),
            pizzaImage(),
            middleData(),
            footerDetails(),
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
                FontAwesomeIcons.trashAlt,
                color: Colors.red,
              ),
              onPressed: () {
                Provider.of<Calculations>(context, listen: false)
                    .removeAllData();
              }),
        ],
      ),
    );
  }

  Widget pizzaImage() {
    return Center(
      child: SizedBox(
        height: 280.0,
        child: Container(
          child: Image.network(widget.queryDocumentSnapshot['image']),
          decoration: BoxDecoration(shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget middleData() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow.shade700,
              size: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.queryDocumentSnapshot['ratings'],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey.shade500,
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 300.0),
              child: Text(
                widget.queryDocumentSnapshot['name'],
                style: TextStyle(
                  fontSize: 34.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.rupeeSign,
                  size: 20.0,
                  color: Colors.cyan,
                ),
                Text(
                  widget.queryDocumentSnapshot['price'].toString(),
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget footerDetails() {
    return SizedBox(
      height: 300.0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 2,
                      spreadRadius: 2,
                    )
                  ]),
              width: 400.0,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add more stuff',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Cheese',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusCheese();
                              },
                            ),
                            Text(
                              Provider.of<Calculations>(context)
                                  .getCheeseValue
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              icon: Icon(EvaIcons.plus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .addCheese();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Bacon',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusBacon();
                              },
                            ),
                            Text(
                              Provider.of<Calculations>(context)
                                  .getBaconValue
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              icon: Icon(EvaIcons.plus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .addBacon();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Onion',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(EvaIcons.minus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .minusOnion();
                              },
                            ),
                            Text(
                              Provider.of<Calculations>(context)
                                  .getOnionValue
                                  .toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            IconButton(
                              icon: Icon(EvaIcons.plus),
                              onPressed: () {
                                Provider.of<Calculations>(context,
                                        listen: false)
                                    .addOnion();
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<Calculations>(context, listen: false)
                      .selectSmallSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Provider.of<Calculations>(context).smallTapped
                        ? Colors.lightBlue
                        : Colors.white,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'S',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<Calculations>(context, listen: false)
                      .selectMediumSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Provider.of<Calculations>(context).mediumTapped
                        ? Colors.lightBlue
                        : Colors.white,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'M',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<Calculations>(context).selectLargeSize();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Provider.of<Calculations>(context, listen: true)
                            .largeTapped
                        ? Colors.lightBlue
                        : Colors.white,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'L',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<Calculations>(context, listen: false)
                .addToCart(context, {
              'image': widget.queryDocumentSnapshot['image'],
              'name': widget.queryDocumentSnapshot['name'],
              'price': widget.queryDocumentSnapshot['price'],
              'onion': Provider.of<Calculations>(context, listen: false)
                  .getOnionValue,
              'cheese': Provider.of<Calculations>(context, listen: false)
                  .getCheeseValue,
              'bacon': Provider.of<Calculations>(context, listen: false)
                  .getBaconValue,
              'size': Provider.of<Calculations>(context, listen: false).getSize,
            });
          },
          child: Container(
            width: 250.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(50.0)),
            child: Center(
              child: Text(
                'Add to cart',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Stack(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: MyCart(), type: PageTransitionType.bottomToTop));
              },
              child: Icon(
                Icons.shopping_basket,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Text(
                  Provider.of<Calculations>(context, listen: false)
                      .getCartData
                      .toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
