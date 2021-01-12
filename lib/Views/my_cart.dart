import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/Providers/authentication.dart';
import 'package:pizzato/Providers/calculations.dart';
import 'package:pizzato/Providers/payment.dart';
import 'package:pizzato/Services/manage_data.dart';
import 'package:pizzato/Services/maps.dart';
import 'package:pizzato/Views/home_screen.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Razorpay razorpay;
  int price = 400;
  int total = 420;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        Provider.of<PaymentHelper>(context, listen: false)
            .handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        Provider.of<PaymentHelper>(context, listen: false).handlePaymentError);
    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        Provider.of<PaymentHelper>(context, listen: false)
            .handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  Future checkMeOut() async {
    final userData = Provider.of<Authentication>(context, listen: false);
    var options = {
      'key': 'rzp_test_rd3eN4UtFfZq00',
      'amount': total,
      'name': userData.getUserEmail == null ? userEmail : userData.getUserEmail,
      'description': 'Payment',
      'prefill': {
        'contact': '8888888888',
        'email':
            userData.getUserEmail == null ? userEmail : userData.getUserEmail,
      },
      'external': {
        'wallet': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            headerText(),
            cartData(),
            Container(
              height: 340.0,
              width: 400.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/space.png')),
              ),
            ),
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
                color: Colors.white,
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
            fontSize: 22.0,
          ),
        ),
        Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 46.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 250.0,
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
                  return GestureDetector(
                    onLongPress: () => placeOrder(context, documentSnapshot),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.lightBlue,
                                blurRadius: 2,
                                spreadRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white.withOpacity(0.8)),
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
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }

  placeOrder(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xFF191531)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 4.0,
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30.0,
                          child: Text(
                            'Time : ${Provider.of<PaymentHelper>(context, listen: true).deliveryTiming.format(context)}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        Container(
                          height: 80.0,
                          child: Text(
                            'Location : ${Provider.of<GenerateMaps>(context, listen: true).getMainAddress}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          FontAwesomeIcons.clock,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectTime(context);
                        }),
                    FloatingActionButton(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          FontAwesomeIcons.mapPin,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<PaymentHelper>(context, listen: false)
                              .selectLocation(context);
                        }),
                    FloatingActionButton(
                        backgroundColor: Colors.green,
                        child: Icon(
                          FontAwesomeIcons.paypal,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await checkMeOut().whenComplete(() {
                            Provider.of<PaymentHelper>(context, listen: false)
                                .showCheckOutButtonMethod();
                          });
                        }),
                  ],
                ),
                if (Provider.of<PaymentHelper>(context, listen: false)
                    .getShowCheckOutButton)
                  MaterialButton(
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('adminCollections')
                            .add({
                          'username': Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserEmail ==
                                  null
                              ? userEmail
                              : Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserEmail,
                          'image': documentSnapshot.data()['image'],
                          'pizza': documentSnapshot.data()['name'],
                          'price': documentSnapshot.data()['price'],
                          'size': documentSnapshot.data()['size'],
                          'onion': documentSnapshot.data()['onion'],
                          'bacon': documentSnapshot.data()['bacon'],
                          'cheese': documentSnapshot.data()['cheese'],
                          'time':
                              Provider.of<PaymentHelper>(context, listen: false)
                                  .deliveryTiming
                                  .format(context),
                          'location':
                              Provider.of<GenerateMaps>(context, listen: false)
                                  .getMainAddress
                        });
                      })
              ],
            ),
          );
        });
  }
}
