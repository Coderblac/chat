import 'package:flutter/material.dart';

class CirleBtn extends StatelessWidget {
  final IconData icon;
  final double iconsize;
  final Function()? onpressed;

  const CirleBtn(
      {super.key,
      required this.icon,
      required this.iconsize,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(6.6),
      // decoration:
      //     BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
      child: IconButton(
        icon: Icon(
          icon,
          size: iconsize,
          color: Colors.white,
        ),
        onPressed: onpressed,
      ),
    );
  }
}
