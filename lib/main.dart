import 'package:chatapp/Chat.dart';
import 'package:chatapp/bottom_navbar.dart';
import 'package:chatapp/homepage.dart';
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
      debugShowCheckedModeBanner: false, home: MainPageLogin(),
      // HiddenDrawer(),
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.dark,
    );
  }
}
