import 'package:chatapp/screens/homepage.dart';
import 'package:chatapp/user%20pages/auth_page.dart';
import 'package:chatapp/user%20pages/main_page.dart';
import 'package:flutter/material.dart';

class Loadscreen extends StatefulWidget {
  @override
  State<Loadscreen> createState() => _LoadscreenState();
}

class _LoadscreenState extends State<Loadscreen> {
  @override
  void initState() {
    // initiateSearch();

    Future.delayed(Duration(seconds: 2, milliseconds: 46), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return MainPageLogin();
      }));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 26, 1),
      body: SafeArea(
        child: Container(
          height: size.height * 1.0,
          width: size.width * 1.0,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Image.asset(
                    'assets/icons/bighit.png',
                    height: size.height * 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
