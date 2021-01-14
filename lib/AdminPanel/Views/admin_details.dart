import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzato/AdminPanel/Services/delivery_options.dart';
import 'package:pizzato/AdminPanel/Services/maps_helpers.dart';
import 'package:provider/provider.dart';

class AdminDetailsHelper with ChangeNotifier {
  detailSheet(BuildContext context, DocumentSnapshot documentSnapshot) {
    Provider.of<MapsHelpers>(context, listen: false)
        .getMarkerData('adminCollections');
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          EvaIcons.person,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            documentSnapshot.data()['username'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapPin,
                            color: Colors.lightBlueAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 360.0),
                              child: Text(
                                documentSnapshot.data()['address'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400.0,
                    width: 400.0,
                    child: Provider.of<MapsHelpers>(context, listen: false)
                        .showGoogleMap(context, documentSnapshot),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.lightGreen,
                            ),
                            Text(
                              documentSnapshot.data()['time'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: Colors.lightBlueAccent,
                            ),
                            Text(
                              documentSnapshot.data()['price'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(documentSnapshot.data()['image']),
                          ),
                          Column(
                            children: [
                              Text(
                                'Pizza: ${documentSnapshot.data()['pizza']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Cheese: ${documentSnapshot.data()['cheese']} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Bacon: ${documentSnapshot.data()['bacon']} ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Onion: ${documentSnapshot.data()['onion']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              documentSnapshot.data()['size'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                    'canceledOrders', 'Delivery Canceled');
                          },
                          icon: Icon(FontAwesomeIcons.eye, color: Colors.white),
                          label: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                    'deliveredOrders', 'Delivery Accepted');
                          },
                          icon: Icon(FontAwesomeIcons.delicious,
                              color: Colors.white),
                          label: Text(
                            'Deliver',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.orangeAccent,
                          onPressed: () {},
                          icon:
                              Icon(FontAwesomeIcons.phone, color: Colors.white),
                          label: Text(
                            'Contact the owner',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFF200B4B),
            ),
          );
        });
  }
}
