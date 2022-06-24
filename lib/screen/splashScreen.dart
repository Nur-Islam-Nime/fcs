import 'package:fcs/screen/login-screen.dart';
import 'package:fcs/screen/userDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AdminDashboard.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    shared();

    Future.delayed(Duration.zero, shared);
  }

  // shared() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('userId');
  //   print(token);
  //   if (token != null) {
  //     print('token: $token');
  //     Timer(Duration(seconds: 2), () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => userDashboard()));
  //     });
  //   } else {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => logInScreen()));
  //   }
  // }

  shared() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => user.email == 'fcsaynapur@gmail.com'
                  ? const AdminDashBoard()
                  : const userDashboard()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => logInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(38.0),
              child: Image.asset("assets/images/logo.png"),
            )),
          ),
        ),
      ),
    );
  }
}
