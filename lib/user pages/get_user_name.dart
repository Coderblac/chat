// ignore_for_file: prefer_const_constructors, prefer_adjacent_string_concatenation, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
// get the collection

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            // ignore: prefer_interpolation_to_compose_strings
            return Text('${data['first name']}' + ' ' + '${data['last name']}');
          }
          return CircularProgressIndicator();
        });
  }
}
