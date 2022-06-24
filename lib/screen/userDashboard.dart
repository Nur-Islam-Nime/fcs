import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcs/widget/customSubmitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';
import 'UsersDeposit.dart';

class userDashboard extends StatefulWidget {
  const userDashboard({Key? key}) : super(key: key);

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {
  File? profilepic;

  getImageFromGrellery() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      setState(() {
        profilepic = convertedFile;
      });
      print("Image selected!");
    } else {
      print("No image selected!");
    }
  }

  uploadImage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("UserProfilePicture")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(profilepic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    FirebaseAuth.instance.currentUser!
        .updatePhotoURL(downloadUrl)

        // FirebaseFirestore.instance
        //     .collection("User-data")
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .update({'userImage': downloadUrl})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        Navigator.pushNamed(context, message.data['path']);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        Navigator.pushNamed(context, message.data['path']);
      }
    });
  }

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
                    child: ClipPath(
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
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  var data = snapshot.data;
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
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
                                    trailing: InkWell(
                                      onTap: () {
                                        dialog();
                                      },
                                      child: FirebaseAuth.instance.currentUser!
                                                  .photoURL !=
                                              null
                                          ? CircleAvatar(
                                              radius: 70,

                                              backgroundImage: NetworkImage(
                                                  FirebaseAuth.instance
                                                      .currentUser!.photoURL!),
                                              backgroundColor:
                                                  Colors.transparent,

                                            )
                                          : Icon(Icons.add_a_photo_outlined),

                                      // NetworkImage("userImage"),
                                      // child: Icon(Icons.add_a_photo_outlined),
                                    ),
                                  );
                                }),
                          )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("User-data")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              var data = snapshot.data;
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading");
                              }
                              if (data == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // CircleAvatar(
                                      //   child: Container(
                                      //     child: (Image.network(data["image"])),
                                      //
                                      //   ),
                                      // ),
                                      const Text("My Current Balance :"),
                                      Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff707070)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 2,
                                              bottom: 2),
                                          child: Text(
                                              data['Balance'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Due :"),
                                      Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff707070)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 2,
                                              bottom: 2),
                                          child: Text(data['Due'],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<double?>(
                            stream: CombineLatestStream.combine2(
                              getProfitFundData(),
                              getUserBalanceData(),
                              (double a, double b) => a + b,
                            ),
                            builder: (context, snapshort) {
                              if (snapshort.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshort.hasData) {
                                double data = snapshort.data!;
                                return Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total fund of FCS :"),
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff707070)),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("$data",
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                ));
                              }

                              return const Text("No data ");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<double?>(
                              stream: getUseOfFundData(),
                              builder: (_, snapshort) {
                                if (snapshort.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshort.hasData) {
                                  double data = snapshort.data!;
                                  return Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total usable funds :"),
                                      Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff707070)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 2,
                                              bottom: 2),
                                          child: Text("$data",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ));
                                }

                                return const Text("No data ");
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<double?>(
                              stream: getProfitFundData(),
                              builder: (_, snapshort) {
                                if (snapshort.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshort.hasData) {
                                  double data = snapshort.data!;
                                  return Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Profit funds :"),
                                      Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff707070)),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 2,
                                              bottom: 2),
                                          child: Text("$data",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ));
                                }

                                return const Text("No data ");
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<double?>(
                            stream: CombineLatestStream.combine3(
                              getProfitFundData(),
                              getUserBalanceData(),
                              getUseOfFundData(),
                              (double a, double b, double c) => (a + b) - c,
                            ),
                            builder: (context, snapshort) {
                              if (snapshort.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshort.hasData) {
                                double data = snapshort.data!;
                                return Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Current funds :"),
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff707070)),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("$data",
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                ));
                              }

                              return const Text("No data ");
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              customSubmitButton("Deposit", () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserDeposit()));
                              })
                            ],
                          ),
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

  dialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(1, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: (profilepic != null)
                            ? FileImage(profilepic!)
                            : null,
                      ),
                      customSubmitButton("Pick Image", () {
                        getImageFromGrellery();
                      }),
                      customSubmitButton("Upload Image", () {
                        uploadImage();
                      }),
                      customSubmitButton("Log out", () async {
                        await FirebaseAuth.instance.signOut();

                        // Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Stream<double> getProfitFundData() async* {
  final result =
      await FirebaseFirestore.instance.collection('Profit-Way').get();
  double totalFundAmount = 0;
  for (var doc in result.docs) {
    totalFundAmount += doc['Amount'];
  }
  yield totalFundAmount;
}

Stream<double> getUserBalanceData() async* {
  final result = await FirebaseFirestore.instance.collection('User-data').get();
  double userTotalAmount = 0;
  for (var doc in result.docs) {
    userTotalAmount += doc['Balance'];
  }
  yield userTotalAmount;
}

Stream<double> getUseOfFundData() async* {
  final result =
      await FirebaseFirestore.instance.collection('Use-of-fund').get();
  double userTotalAmount = 0;
  for (var doc in result.docs) {
    userTotalAmount += doc['Amount'];
  }
  yield userTotalAmount;
}
