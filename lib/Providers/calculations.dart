import 'package:flutter/material.dart';
import 'package:pizzato/Services/manage_data.dart';
import 'package:provider/provider.dart';

class Calculations with ChangeNotifier {
  int cheeseValue = 0, baconValue = 0, onionValue = 0, cartData = 0;
  String size;
  bool isSelected = false,
      smallTapped = false,
      mediumTapped = false,
      largeTapped = false,
      selected = false;

  int get getCheeseValue => cheeseValue;

  int get getBaconValue => baconValue;

  int get getOnionValue => onionValue;

  int get getCartData => cartData;

  String get getSize => size;

  addCheese() {
    cheeseValue++;
    notifyListeners();
  }

  addBacon() {
    baconValue++;
    notifyListeners();
  }

  addOnion() {
    onionValue++;
    notifyListeners();
  }

  minusCheese() {
    cheeseValue--;
    notifyListeners();
  }

  minusBacon() {
    baconValue--;
    notifyListeners();
  }

  minusOnion() {
    onionValue--;
    notifyListeners();
  }

  selectSmallSize() {
    smallTapped = true;
    size = 'S';
    notifyListeners();
  }

  selectMediumSize() {
    mediumTapped = true;
    size = 'M';
    notifyListeners();
  }

  selectLargeSize() {
    largeTapped = true;
    size = 'L';
    notifyListeners();
  }

  removeAllData() {
    cheeseValue = 0;
    baconValue = 0;
    onionValue = 0;
    smallTapped = false;
    mediumTapped = false;
    largeTapped = false;
    notifyListeners();
  }

  addToCart(BuildContext context, dynamic data) async {
    if (smallTapped != false || mediumTapped != false || largeTapped != false) {
      cartData++;
      await Provider.of<ManageData>(context, listen: false)
          .submitData(context, data);
      notifyListeners();
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.black54,
              height: 50.0,
              child: Center(
                child: Text(
                  'Select Size!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          });
    }
  }
}
