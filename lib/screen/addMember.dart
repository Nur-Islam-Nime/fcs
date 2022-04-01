import 'package:fcs/widget/CustomAdminDashboard.dart';
import 'package:fcs/widget/customTextField.dart';
import 'package:fcs/widget/logInButton.dart';
import 'package:flutter/material.dart';

class addMember extends StatelessWidget {
  const addMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03062d),
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
                        children:  [
                          const Center(
                              child: Text(
                                "Add Member",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Montserrat-BoldItalic",
                                    color: Color(0xffed8073)),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                customTextField("Email/Mobile", false),
                                customTextField("password", true),
                                SizedBox(height: MediaQuery.of(context).size.height/65,),
                                customLoginButton("Add Member")
                              ],
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
