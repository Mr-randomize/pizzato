import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/AdminPanel/Services/admin_detail_helper.dart';
import 'package:pizzato/AdminPanel/Views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(context),
      appBar: appBar(context),
      drawer: Drawer(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Stack(
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
                      Color(0xFF200B4B),
                      Color(0xFF201F22),
                      Color(0xFF1A1031),
                      Color(0xFF19181F),
                    ]),
              ),
            ),
            dateChip(context),
            orderData(context),
          ],
        ),
      ),
    );
  }

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
                    child: AdminLogin(), type: PageTransitionType.leftToRight),
              );
            }),
      ],
      centerTitle: true,
      title: Text(
        'Orders',
        style: TextStyle(
            color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget dateChip(BuildContext context) {
    return Positioned(
      top: 20.0,
      child: Container(
        width: 400.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text(
                  'Today',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text(
                  'This Week',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
            ActionChip(
                backgroundColor: Colors.purple,
                label: Text(
                  'This Month',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget orderData(BuildContext context) {
    return Positioned(
      top: 100.0,
      child: SizedBox(
        height: 800.0,
        width: 400.0,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('adminCollections')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ListView(
                  children: snapshot.data.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        child: ListTile(
                          onTap: () => Provider.of<AdminDetailHelper>(context,
                                  listen: false)
                              .detailSheet(context, documentSnapshot),
                          trailing: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.magnet,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          title: Text(
                            documentSnapshot.data()['pizza'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            documentSnapshot.data()['address'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(documentSnapshot.data()['image']),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          onPressed: () {},
          backgroundColor: Colors.greenAccent,
        ),
        FloatingActionButton(
          child: Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
          backgroundColor: Colors.redAccent,
        ),
      ],
    );
  }
}
