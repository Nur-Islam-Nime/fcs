import 'package:flutter/material.dart';
Widget customSubmitButton(String text){
  return Container(
    decoration: BoxDecoration(
        color:Colors.white, borderRadius: BorderRadius.circular(10)),
    child: TextButton(onPressed: () {}, child: Padding(
      padding: const EdgeInsets.only(left: 20,right: 20, top: 5,bottom: 5),
      child: Text(text, style: const TextStyle(color: Color(0xffed8073)),),
    )),
  );
}