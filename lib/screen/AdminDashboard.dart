import 'package:fcs/modelClass/customIcon.dart';
import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/CustomGrid.dart';
import 'package:flutter/material.dart';

import 'addMember.dart';
import 'memberDetials.dart';

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
            child: Column(

              children: [

                Expanded(
                  flex: 2,
                    child: customAdminDashboard()
                ),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35, top: 10,bottom: 10),
                      child: Container(
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,

                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomGrid(Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: (Image.asset("assets/images/member.png")),
                                ),(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MemberDetails()));
                                } ),
                                CustomGrid(Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: (Image.asset("assets/images/save-money.png")),
                                ),(){} ),
                                CustomGrid(Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: (Image.asset("assets/images/payment.png")),
                                ),(){} ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               CustomGrid(Padding(
                                 padding: const EdgeInsets.all(6.0),
                                 child: (Image.asset("assets/images/add-member.png",)),
                               ),(){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const addMember()));
                               } ),
                               CustomGrid(Padding(
                                 padding: const EdgeInsets.all(6.0),
                                 child: (Image.asset("assets/images/money.png")),
                               ),(){} ),
                               CustomGrid(Padding(
                                 padding: const EdgeInsets.all(6.0),
                                 child: (Image.asset("assets/images/history.png")),
                               ),(){} ),
                             ],
                            )
                          ],
                        ) ,
                      ),
                    )

                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

