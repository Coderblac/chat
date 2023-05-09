// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final cardNumber;
  final String label;
  final color;
  final color2;
  const MyCard(
      {Key? key,
      required this.cardNumber,
      this.color,
      this.color2,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Container(
        width: 20,
        padding: EdgeInsets.all(28),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: color2,
                blurRadius: 55,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/icons/how-to-become-a-programmer-in-india.jpg',
                  height: 20,
                ),
                Text(
                  'Balance',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              label.toString(),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
