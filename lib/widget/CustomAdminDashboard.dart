import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

Widget customAdminDashboard( ){
  return ClipPath(
    clipper: WaveClipperTwo(flip: true),

    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(


          decoration: const BoxDecoration(
              gradient: LinearGradient(

                colors: [Color(0xffce546e), Color(0xff8d4f96)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
        ),
        Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Image.asset("assets/images/logo2.png",
                    height: 90,
                    width: 90,

                  ),
                ),
                const Text("ADMIN DASHBOARD", style: TextStyle(color: Colors.white),)

              ],
            )
        ),

      ],
    ),

  );
}