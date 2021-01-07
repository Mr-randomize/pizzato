import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  String uid;
  dynamic errorMessage = '';

  dynamic get getErrorMessage => errorMessage;

  String get getUid => uid;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginIntoAccount(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      uid = user.uid;
      prefs.setString('uid', uid);
      notifyListeners();
    } catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User Not Found';
          print(errorMessage);
          break;
        case 'wrong-password':
          errorMessage = 'Oops, Wrong Password';
          print(errorMessage);
          break;
        case 'invalid-email':
          errorMessage = 'Sorry, invalid email';
          print(errorMessage);
          break;
      }
    }
  }

  Future createNewAccount(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      uid = user.uid;
      prefs.setString('uid', uid);
      notifyListeners();
    } catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Email already in use';
          print(errorMessage);
          break;

        case 'invalid-email':
          errorMessage = 'Sorry, invalid email';
          print(errorMessage);
          break;
      }
    }
  }
}
