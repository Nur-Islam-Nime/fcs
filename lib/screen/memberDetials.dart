import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: [
          Container(
              height: MediaQuery.of(context).size.height/2.5,
              child: customAdminDashboard()),
          StreamBuilder<QuerySnapshot>(
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
                return Text("Loading");
              }

              return DraggableScrollableSheet(
               // double initialChildSize: 0.2,
               //    maxChildSize: 0.3,
                //   minChildSize: 0.4,
                  builder: (context,controller)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white24,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Member Name",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xff925093)),
                              ),
                              Text("Balance",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff925093))),
                            ],
                          ),
                          ListView.builder(
                            controller: controller,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                DocumentSnapshot _DocumentSnapshot =
                                snapshot.data!.docs[index];
                                return ListTile(
                                  leading: Text(_DocumentSnapshot['Name']),
                                  trailing: Text(
                                      _DocumentSnapshot['Balance'].toString()),
                                );
                              }),
                        ],
                      ),
                    ),
                  )
              );
            },
          )
        ],
      )
    );
  }

}


