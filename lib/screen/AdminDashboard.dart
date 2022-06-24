import 'package:fcs/screen/userDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/CustomAdminDashboard.dart';
import '../widget/customGrid.dart';
import 'FundsUsesHistory.dart';
import 'ProfitWay.dart';
import 'UseOfFund.dart';
import 'addMember.dart';
import 'transaction.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(flex: 2, child: customAdminDashboard()),
            Expanded(
                flex: 3,
                child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: (Image.asset("assets/images/member.png",
                                    fit: BoxFit.fill)),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const userDetails()));
                          }),
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (Image.asset(
                                    "assets/images/save-money.png",
                                    fit: BoxFit.fill)),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => transaction()));
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (Image.asset("assets/images/payment.png",
                                    fit: BoxFit.fill)),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UseOfFund()));
                          }),
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (Image.asset(
                                  "assets/images/add-member.png",
                                  fit: BoxFit.fill,
                                )),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMember()));
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (Image.asset("assets/images/money.png",
                                    fit: BoxFit.fill)),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfitWay()));
                          }),
                          CustomGrid(
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (Image.asset("assets/images/history.png",
                                    fit: BoxFit.fill)),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FundsUsesHistory()));
                          }),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ))),
    );
  }
}
