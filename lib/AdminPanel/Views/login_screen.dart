import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pizzato/AdminPanel/Views/admin_home_screen.dart';
import 'package:pizzato/Providers/authentication.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Container(
            height: 500.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/adminlogin.png'),
              ),
            ),
          ),
          Positioned(
            top: 420.0,
            left: 10.0,
            child: Container(
              height: 200.0,
              width: 200.0,
              child: RichText(
                text: TextSpan(
                    text: 'Pizzato ',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 46.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'At Your ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                      TextSpan(
                        text: 'Service',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 620.0,
            child: Container(
              width: 400.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      loginSheet(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: Colors.white)),
                      width: 100.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      signUpSheet(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: Colors.white)),
                      width: 100.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 720.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: 400.0,
              constraints: BoxConstraints(maxHeight: 200.0),
              child: Column(
                children: [
                  Text(
                    "By continuing you agree Pizzato's Terms of ",
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
                  ),
                  Text(
                    "Services & Privacy Policy",
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xDD191531)),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Email...',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password...',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.lightBlueAccent,
                        child:
                            Icon(FontAwesomeIcons.check, color: Colors.white),
                        onPressed: () =>
                            Provider.of<Authentication>(context, listen: false)
                                .loginIntoAccount(emailController.text,
                                    passwordController.text)
                                .whenComplete(() {
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage !=
                                  '') {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: AdminLogin(),
                                      type: PageTransitionType.leftToRight,
                                    ));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: AdminHomeScreen(),
                                      type: PageTransitionType.leftToRight,
                                    ));
                              }
                            })),
                  ),
                  Text(
                    Provider.of<Authentication>(context, listen: true)
                        .getErrorMessage,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }

  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xDD191531)),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Email...',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password...',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Colors.lightBlueAccent,
                        child:
                            Icon(FontAwesomeIcons.check, color: Colors.white),
                        onPressed: () =>
                            Provider.of<Authentication>(context, listen: false)
                                .createNewAccount(emailController.text,
                                    passwordController.text)
                                .whenComplete(() {
                              if (Provider.of<Authentication>(context,
                                          listen: false)
                                      .getErrorMessage !=
                                  '') {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: AdminLogin(),
                                      type: PageTransitionType.leftToRight,
                                    ));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: AdminHomeScreen(),
                                      type: PageTransitionType.leftToRight,
                                    ));
                              }
                            })),
                  ),
                  Text(
                    Provider.of<Authentication>(context, listen: true)
                        .getErrorMessage,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        });
  }
}
