import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/CustomDepositTextField.dart';
import 'package:fcs/widget/CustomListtile.dart';
import 'package:fcs/widget/CustomUserDetails.dart';
import 'package:fcs/widget/CustomlogInButton.dart';
import 'package:fcs/widget/customSubmitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDeposit extends StatefulWidget {
  @override
  State<UserDeposit> createState() => _UserDepositState();
}

class _UserDepositState extends State<UserDeposit> {
  final TextEditingController _payableAmountController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _paymentGetawayController =
      TextEditingController();

  final TextEditingController _transactionIdController =
      TextEditingController();





  sandUserDataToDB( ) async {


    CollectionReference _collectionReferance =
    FirebaseFirestore.instance.collection("Panding-Transections");
    return _collectionReferance
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "Name": _nameController.text,
      "PayableAmount": _payableAmountController.text,
      "PaymentGetaway": _paymentGetawayController.text,
      "TransactionId": _transactionIdController.text,
    })
        .then((value) => dialog())
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
                Expanded(
                    flex: 2,
                    child: ClipPath(
                      clipper: WaveClipperTwo(flip: true),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffce546e), Color(0xff8d4f96)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ),
                          Positioned(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("User-data")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      var data = snapshot.data;
                                      if (snapshot.hasError) {
                                        return const Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text("Loading");
                                      }
                                      if (data == null) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ListTile(
                                        title: Text(
                                          data['Name'],
                                          style: const TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // subtitle: Text(),
                                        trailing: InkWell(
                                          onTap: () {
                                          },
                                          child:   FirebaseAuth.instance.currentUser!.photoURL != null
                                              ?CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                              NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!))
                                              : Icon(Icons.add_a_photo_outlined),

                                          // NetworkImage("userImage"),
                                          // child: Icon(Icons.add_a_photo_outlined),
                                        ),
                                      );

                                    }),
                              )),
                        ],
                      ),
                    )

                ),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        customDepositTextField(
                            "name", "Enter your name", _nameController),
                        customDepositTextField("Payable amount",
                            "Payable amount", _payableAmountController),
                        customDepositTextField("Payment Getaway", "Bkash/Roket",
                            _paymentGetawayController),
                        customDepositTextField(
                            "Transaction Id", "121", _transactionIdController),
                        customSubmitButton("Send", () {
                          if (_nameController.text.isNotEmpty) {
                            sandUserDataToDB( );
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "You have to enter your valid name");
                          }
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

  dialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(1, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                            color: Color(0xfff4afa7),
                            fontSize: 26,
                            fontFamily: "Montserrat-SemiBold"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 40, right: 40),
                        child: Text(
                          "Your deposit has been succeed ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "Please wait for confirmations ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
