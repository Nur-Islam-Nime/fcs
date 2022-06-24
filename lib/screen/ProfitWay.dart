import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/CustomAdminTextField.dart';
import 'package:fcs/widget/customSubmitButton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'FundsUsesHistory.dart';

class ProfitWay extends StatefulWidget {
  @override
  State<ProfitWay> createState() => _ProfitWayState();
}

class _ProfitWayState extends State<ProfitWay> {
  TextEditingController _DetailsofSectorController = TextEditingController();

  TextEditingController _ThroughController = TextEditingController();

  TextEditingController _AmountController = TextEditingController();

  TextEditingController _DateController = TextEditingController();

  sandDataToDB() async {
    CollectionReference _collectionReferance =
        FirebaseFirestore.instance.collection("Profit-Way");
    return _collectionReferance
        .doc()
        .set({
          "Details of Sector": _DetailsofSectorController.text,
          "Through": _ThroughController.text,
          "Amount": int.parse(_AmountController.text),
          "Date": _DateController.text,
        })
        .then((value) => dialog())
        .catchError((error) => Fluttertoast.showToast(msg: "something wrong"));
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
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Your data has been saved",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xfff4afa7),
                          fontSize: 26,
                          fontFamily: "Montserrat-SemiBold"),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      child: ListView(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          const Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Profit Way",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Montserrat-BoldItalic",
                                  color: Color(0xffed8073)),
                            ),
                          )),
                          customAdminTextField(
                              "Details of Sector", _DetailsofSectorController),
                          customAdminTextField("Through", _ThroughController),
                          customAdminTextField("Amount", _AmountController),
                          customAdminTextField("Date", _DateController),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 90.0, right: 90, bottom: 20),
                            child: customSubmitButton("Submit ", () {
                              sandDataToDB();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FundsUsesHistory()));
                            }),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
