import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ivi.berberi/AndroidStudioProjects/pizzato/lib/AdminPanel/Views/admin_details.dart';
import 'package:pizzato/AdminPanel/Services/delivery_options.dart';
import 'package:pizzato/AdminPanel/Services/maps_helpers.dart';
import 'package:pizzato/Helpers/footer.dart';
import 'package:pizzato/Helpers/headers.dart';
import 'package:pizzato/Helpers/middle.dart';
import 'package:pizzato/Providers/authentication.dart';
import 'package:pizzato/Providers/calculations.dart';
import 'package:pizzato/Providers/payment.dart';
import 'package:pizzato/Services/manage_data.dart';
import 'package:pizzato/Services/maps.dart';
import 'package:pizzato/Views/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Authentication()),
        ChangeNotifierProvider(create: (ctx) => Headers()),
        ChangeNotifierProvider(create: (ctx) => MiddleHelpers()),
        ChangeNotifierProvider(create: (ctx) => ManageData()),
        ChangeNotifierProvider(create: (ctx) => Footers()),
        ChangeNotifierProvider(create: (ctx) => GenerateMaps()),
        ChangeNotifierProvider(create: (ctx) => Calculations()),
        ChangeNotifierProvider(create: (ctx) => PaymentHelper()),
        ChangeNotifierProvider(create: (ctx) => AdminDetailsHelper()),
        ChangeNotifierProvider(create: (ctx) => DeliveryOptions()),
        ChangeNotifierProvider(create: (ctx) => MapsHelpers()),
      ],
      child: MaterialApp(
        title: 'Pizzato',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.transparent,
          fontFamily: 'Monteserat',
          primarySwatch: Colors.red,
          primaryColor: Colors.redAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
