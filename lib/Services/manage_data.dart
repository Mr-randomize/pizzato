import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizzato/Providers/authentication.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:provider/provider.dart';

class ManageData extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future fetchData(String collection) async {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection(collection).get();
    return querySnapshot.docs;
  }

  Future submitData(BuildContext context, dynamic data) async {
    return firebaseFirestore
        .collection('myOrders')
        .doc(Provider.of<Authentication>(context, listen: false).getUid)
        .set(data);
  }

  Future deleteData(BuildContext context) async {
    return firebaseFirestore
        .collection('myOrders')
        .doc(Provider.of<Authentication>(context, listen: false).getUid == null
            ? userUid
            : Provider.of<Authentication>(context, listen: false).getUid)
        .delete();
  }
}
