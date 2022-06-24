import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

Widget customUserDetails() {
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
            child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User-data")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var data = snapshot.data;
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                if (data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListTile(
                  title: Text(
                    data['Name'],
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  // subtitle: Text(),
                  trailing: const CircleAvatar(
                    child: Icon(Icons.add_a_photo_outlined),
                  ),

                );
              }),
        )),
      ],
    ),
  );
}
