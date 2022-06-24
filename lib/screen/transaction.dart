import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/CustomAdminDashboard.dart';

class transaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(flex: 2, child: customAdminDashboard()),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Transaction Confirmation",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Montserrat-BoldItalic",
                          color: Color(0xffed8073)),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 2, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Member Name",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff925093),
                          ),
                        ),
                        Text("Amount",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff925093))),
                        Text("Confirm",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff925093))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Panding-Transections")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }
                          // if (snapshot.hasData ) {
                          //   return Center(child: Container(child: Text("Document does not exist")));
                          // }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                DocumentSnapshot _DocumentSnapshot =
                                    snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 2 ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          flex: 6,
                                          child: Row(

                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(
                                                (index + 1).toString() +
                                                    "." +

                                                    " " +
                                                    _DocumentSnapshot['Name'],
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 70,
                                                child: Text(
                                                    _DocumentSnapshot[
                                                        'PayableAmount'],
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        TextStyle(fontSize: 18)),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffed8073),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ))),
                                            TextButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "Panding-Transections")
                                                      .doc()
                                                      .delete();
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffed8073),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
