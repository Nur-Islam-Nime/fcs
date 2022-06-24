import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/screen/AdminDashboard.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/CustomDepositTextField.dart';
import 'package:fcs/widget/customSubmitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserData extends StatefulWidget {
  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _userBalanceController = TextEditingController();

  final TextEditingController _userDueBalanceController =
      TextEditingController();

  sandUserDataToDB() async {
    CollectionReference _collectionReferance =
        FirebaseFirestore.instance.collection("User-data");
    return _collectionReferance
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          "Name": _userNameController.text,
          "Balance": int.parse(_userBalanceController.text),
          "Due": _userDueBalanceController.text,
          "userID": FirebaseAuth.instance.currentUser!.uid,
          "userImage": " ",
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => Fluttertoast.showToast(msg: "something wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(flex: 2, child: customAdminDashboard()),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        customDepositTextField(
                            "User Name", "name", _userNameController),
                        customDepositTextField("Users current balance ",
                            "balance", _userBalanceController),
                        customDepositTextField(
                            "Due amount", "Due", _userDueBalanceController),
                        customSubmitButton("Create", () {
                          sandUserDataToDB();
                          // Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashBoard()));
                          Fluttertoast.showToast(msg: " User data added");
                        })
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
