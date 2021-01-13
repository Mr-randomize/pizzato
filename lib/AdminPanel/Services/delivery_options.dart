import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryOptions with ChangeNotifier {
  showOrders(BuildContext context, String collection) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection(collection).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: snapshot.data.docs
                      .map((DocumentSnapshot documentSnapshot) => ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.mapPin,
                                color: Colors.green,
                              ),
                              onPressed: () {},
                            ),
                            title: Text(
                              documentSnapshot.data()['address'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              documentSnapshot.data()['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  documentSnapshot.data()['image']),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          );
        });
  }

  //Firestore operations
  Future manageOrders(BuildContext context, DocumentSnapshot documentSnapshot,
      String collection) async {
    await FirebaseFirestore.instance.collection(collection).add({
      'image': documentSnapshot.data()['image'],
      'name': documentSnapshot.data()['name'],
      'pizza': documentSnapshot.data()['pizza'],
      'address': documentSnapshot.data()['address'],
      'location': documentSnapshot.data()['location'],
    });
  }
}
