import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;

  DetailedScreen({this.queryDocumentSnapshot});

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.queryDocumentSnapshot['name']),
      ),
    );
  }
}
