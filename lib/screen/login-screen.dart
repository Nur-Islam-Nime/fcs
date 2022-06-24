import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/CustomlogInButton.dart';
import '../widget/customTextField.dart';
import 'AdminDashboard.dart';
import 'userDashboard.dart';

class logInScreen extends StatefulWidget {
  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignIn() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        var authCredential = userCredential.user;

        if (authCredential!.uid.isNotEmpty &&
            _emailController.text == "fcsaynapur@gmail.com") {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString("userId", FirebaseAuth.instance.currentUser!.uid );
          // print(FirebaseAuth.instance.currentUser!.uid);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminDashBoard()));
        } else {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString("userId", FirebaseAuth.instance.currentUser!.uid );
          // print(FirebaseAuth.instance.currentUser!.uid);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const userDashboard()));
          // Fluttertoast.showToast(
          //   msg: "Please enter admin email",
          // );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
            msg: "No user found for that email.",
          );
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
          );
        }
      } catch (e) {}
    }

    return Scaffold(
        backgroundColor: const Color(0xff03062d),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xffce546e),
                                Color(0xff8d4f96)
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                        Positioned(
                          top: 20,
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        customTextField(
                            "Email/Mobile", _emailController, false),
                        customTextField("password", _passwordController, true),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 65,
                        ),
                        customLoginButton("LOG IN", () {
                          SignIn();
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
