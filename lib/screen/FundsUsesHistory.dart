import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FundsUsesHistory extends StatefulWidget {
  const FundsUsesHistory({Key? key}) : super(key: key);



  @override
  State<FundsUsesHistory> createState() => _FundsUsesHistoryState();

}

class _FundsUsesHistoryState extends State<FundsUsesHistory> {

@override


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
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: ListView(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                " Main Balance :",
                                style: TextStyle(fontSize: 18),
                              ),
                              StreamBuilder<double?>(
                                stream: CombineLatestStream.combine2(
                                  getProfitFundData(),
                                  getUserBalanceData(),
                                  (double a, double b) => a + b,
                                ),
                                builder: (context, snapshort) {
                                  if (snapshort.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshort.hasData) {
                                    double data = snapshort.data!;
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text(
                                          "$data",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ));
                                  }

                                  return const Text("No data ");
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                " Remaining Balance :",
                                style: TextStyle(fontSize: 18),
                              ),
                              StreamBuilder<double?>(
                                stream: CombineLatestStream.combine3(
                                  getProfitFundData(),
                                  getUserBalanceData(),
                                  getUseOfFundData(),
                                  (double a, double b, double c) => (a + b) - c,
                                ),
                                builder: (context, snapshort) {
                                  if (snapshort.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshort.hasData) {
                                    double data = snapshort.data!;
                                    return Center(
                                        child: Column(
                                      children: [
                                        Text("$data",
                                            style:
                                                const TextStyle(fontSize: 18)),
                                      ],
                                    ));
                                  }

                                  return const Text("No data ");
                                },
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Funds Uses History",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Montserrat-BoldItalic",
                                    color: Color(0xffed8073)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff925093),
                                ),
                              ),
                              Text("Amount",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff925093))),
                              Text("Through",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff925093))),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Use-of-fund")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        DocumentSnapshot _DocumentSnapshot =
                                            snapshot.data!.docs[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      (index + 1).toString() +
                                                          "." +
                                                          " " +
                                                          " " +
                                                          _DocumentSnapshot[
                                                              'Details of Sector'],
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      width: 70,
                                                      child: Text(
                                                          _DocumentSnapshot[
                                                                  'Amount']
                                                              .toString(),
                                                          textAlign: TextAlign
                                                              .start,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                    ),
                                                    SizedBox(
                                                      width: 70,
                                                      child: Text(
                                                          _DocumentSnapshot[
                                                              'Through'],
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 8),
                            child: Center(
                              child: Text(
                                "Profit Funds",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Montserrat-BoldItalic",
                                    color: Color(0xffed8073)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Name",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff925093),
                                ),
                              ),
                              Text("Amount",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff925093))),
                              Text("Through",
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xff925093))),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Profit-Way")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        DocumentSnapshot _DocumentSnapshot =
                                            snapshot.data!.docs[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                flex: 6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      (index + 1).toString() +
                                                          "." +
                                                          " " +
                                                          " " +
                                                          _DocumentSnapshot[
                                                              'Details of Sector'],
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                        _DocumentSnapshot[
                                                                'Amount']
                                                            .toString(),
                                                        // textAlign: TextAlign.start,
                                                        style: const TextStyle(
                                                            fontSize: 18)),
                                                    SizedBox(
                                                      width: 70,
                                                      child: Text(
                                                          _DocumentSnapshot[
                                                              'Through'],
                                                          textAlign: TextAlign
                                                              .start,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      18)),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
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

Stream<double> getProfitFundData() async* {
  final result =
      await FirebaseFirestore.instance.collection('Profit-Way').get();
  double totalFundAmount = 0;
  for (var doc in result.docs) {
    totalFundAmount += doc['Amount'];
  }
  yield totalFundAmount;
}

Stream<double> getUserBalanceData() async* {
  final result = await FirebaseFirestore.instance.collection('User-data').get();
  double userTotalAmount = 0;
  for (var doc in result.docs) {
    userTotalAmount += doc['Balance'];
  }
  yield userTotalAmount;
}

Stream<double> getUseOfFundData() async* {
  final result = await FirebaseFirestore.instance.collection('Use-of-fund').get();
  double userTotalAmount = 0;
  for (var doc in result.docs) {
    userTotalAmount += doc['Amount'];
  }
  yield userTotalAmount;
}


// Stream<double> getProfitFundData() {
//   return FirebaseFirestore.instance.collection('Profit-Way').snapshots().map(
//         (snapshot) {
//       return snapshot.docs
//           .map((doc) => doc.data()['Amount'])
//           .reduce((a, b) => a + b);
//     },
//   );
// }

// Stream<double> getUserBalanceData() {
//   return FirebaseFirestore.instance.collection('User-data').snapshots().map(
//         (snapshot) {
//       return snapshot.docs
//           .map((doc) => doc.data()['Balance'])
//           .reduce((a, b) => a + b);
//     },
//   );
// }

// Stream<double> getUseOfFundData() {
//   return FirebaseFirestore.instance.collection('Use-of-fund').snapshots().map(
//         (snapshot) {
//       return snapshot.docs
//           .map((doc) => doc.data()['Amount'])
//           .reduce((a, b) => a + b);
//     },
//   );
// }
//
// Stream<double> getUserBalanceData() {
//   return FirebaseFirestore.instance.collection('User-data').snapshots().map(
//         (snapshot) {
//       return snapshot.docs.map((doc) {
//         final balance = doc.data()['Balance'] as double;
//         print(balance);
//         return balance;
//       }).reduce((double a, double b) => a + b);
//     },
//   );
// }

