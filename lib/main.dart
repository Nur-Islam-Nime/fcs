import 'package:fcs/screen/UsersDeposit.dart';
import 'package:fcs/screen/login-screen.dart';
import 'package:fcs/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FCS Aynapur ',
      theme: ThemeData(
        fontFamily: "Montserrat",
        // primarySwatch: Color("0xff8d4f96"),
      ),
      home: splashScreen(),
      routes: {"deposit": (context) => UserDeposit()},
    );
  }
}
