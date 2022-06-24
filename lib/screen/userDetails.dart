import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/CustomAdminDashboard.dart';

class userDetails extends StatelessWidget {
  const userDetails({Key? key}) : super(key: key);

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
                      child: Text(
                    "Details of Member",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Montserrat-BoldItalic",
                        color: Color(0xffed8073)),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 2, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Member Name",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xff925093)),
                        ),
                        Text("Balance",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff925093))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("User-data")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }


                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
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
                                      left: 15, right: 15, top: 0,bottom: 0),
                                  child: ListTile(
                                    leading: Text((index + 1).toString() +
                                        "." +
                                        " " +
                                        " " +
                                        _DocumentSnapshot['Name'], style: const TextStyle(fontSize: 18, )),
                                    trailing: SizedBox(
                                      width: 50,
                                      child: Text(_DocumentSnapshot['Balance']
                                          .toString(), style: const TextStyle(fontSize: 18)),
                                    ),
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
