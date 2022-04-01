import 'package:flutter/material.dart';

Widget customLoginButton(String text) {
  return Container(
    decoration: BoxDecoration(
        color:Colors.white, borderRadius: BorderRadius.circular(10)),
    child: TextButton(onPressed: () {}, child: Padding(
      padding: const EdgeInsets.only(left: 60,right: 60, top: 5,bottom: 5),
      child: Text(text, style: const TextStyle(color: Color(0xff03062d)),),
    )),
  );
}
