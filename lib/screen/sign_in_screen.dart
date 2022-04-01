import 'package:fcs/widget/customTextField.dart';
import 'package:fcs/widget/logInButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        backgroundColor: const Color(0xff03062d),
        body: SafeArea(
          child: SingleChildScrollView(

            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xffce546e), Color(0xff8d4f96)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        ),
                        Positioned(
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(38.0),
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Column(

                      children: [
                        TabBar(
                          indicatorColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          controller: _tabController,
                          tabs: [Tab(text: "ADMIN"), Tab(text: "PERSON")],
                        ),
                        Expanded(

                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: [
                                  customTextField("Email/Mobile", false),
                                  customTextField("password", true),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 65,
                                  ),
                                  customLoginButton("LOG IN")
                                ],
                              ),
                              Column(
                                children: [
                                  customTextField("Email/Mobile", false),
                                  customTextField("password", true),
                                  SizedBox(height: MediaQuery.of(context).size.height/65,),
                                  customLoginButton("LOG IN")
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
