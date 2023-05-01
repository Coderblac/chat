// ignore_for_file: prefer_const_constructors, dead_code

import 'package:chatapp/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

class MainPageLogin extends StatelessWidget {
  const MainPageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
