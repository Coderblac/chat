import 'package:chatapp/config/palette.dart';
import 'package:chatapp/widget/bottom_navbar.dart';
import 'package:chatapp/screens/homepage.dart';
import 'package:chatapp/pages/loadscreen.dart';
import 'package:chatapp/user%20pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebasefireszz';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   getUserLoggedInStatus();
  // }

  // getUserLoggedInStatus() async {
  //   await HelperFunction.getUserLoggedInStatus().then((value) {
  //     if (value != null) {
  //       bool _isSignedIn = value;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          primaryColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palette.scaffold),
    );
  }
}
