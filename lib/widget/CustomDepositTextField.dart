import 'package:flutter/material.dart';

Widget customDepositTextField(String titleText, String hintText, controller ){
  return Padding(
    padding: const EdgeInsets.only(left: 30,right: 30,top: 6,bottom: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText),
        Container(
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xff707070), width: 1)
          ),
          child: TextField(
            controller:controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              hintText: hintText
            ),
          ),
        )
      ],
    )
  );
}