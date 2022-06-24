import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/customTextField.dart';
import 'package:fcs/widget/CustomlogInButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UserData.dart';

class AddMember extends StatefulWidget {
  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  addMember() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      var authCredential = userCredential.user;

      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: "User added");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserData()));
      } else {
        Fluttertoast.showToast(
          msg: "Something is wrong",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak. ");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03062d),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(flex: 2, child: customAdminDashboard()),
                Expanded(
                    flex: 3,
                    child: ListView(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        const Center(
                            child: Text(
                          "Add Member",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Montserrat-BoldItalic",
                              color: Color(0xffed8073)),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              // customTextField("name", _nameController, false),
                              customTextField(
                                  "Email/Mobile", _emailController, false),
                              customTextField(
                                  "password", _passwordController, true),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 65,
                              ),
                              customLoginButton("Add member", () {
                                addMember();
                              }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 65,
                              ),
                              customLoginButton("Log out", () async {
                                await FirebaseAuth.instance.signOut();
                              })
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
