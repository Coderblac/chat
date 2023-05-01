// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showloginPage;
  const RegisterPage({super.key, required this.showloginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        Navigator.of(context).pop();
        addUserDetails(_firstNameController.text.trim(),
            _lastNameController.text.trim(), _emailController.text.trim());
      } on FirebaseAuthException catch (e) {
        (e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }
    }
  }

  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text('Register',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                Text(
                  'Hello 👋, Fill the Form below',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),

                // first name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.8),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'First Name'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // last name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.8),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Last Name'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.8),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.8),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // confirm password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(.8),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // signIn Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      width: size.width * .9,
                      height: size.height * .06,
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // not a member? Register Now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: widget.showloginPage,
                      child: Text(
                        ' Login Now',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
