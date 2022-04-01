import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:flutter/material.dart';

class MemberDetails extends StatelessWidget {
  const MemberDetails({Key? key}) : super(key: key);

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
                    child: Container(
                      child: Column(
                        children: const [
                          Center(
                              child: Text(
                            "Detials of Member",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Montserrat-BoldItalic",
                                color: Color(0xffed8073)),
                          )),
                          // ListView.builder(itemBuilder: )
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
