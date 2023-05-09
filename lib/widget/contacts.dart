import 'package:chatapp/data/data.dart';
import 'package:chatapp/screens/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../config/palette.dart';
import '../widget/circle_btn.dart';
import '../widget/create_post.dart';
import '../widget/rooms.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  var lastDoc;

  bool newMsg = false;

  void _getUnreadCount(String collectionName, int index) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .where('read', isEqualTo: false)
            .where('receiver',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get()
        //     .then((value) {
        //   for (var docSnapshot in value.docs) {
        //     print(
        //         DateTime.fromMillisecondsSinceEpoch(docSnapshot.get('timestamp')));

        //   }
        //   return value;
        // })
        ;

    if (snapshot.size > 0) {
      lastDoc = await FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy('timestamp', descending: true)
          .get();
      if (lastDoc != null)
        setState(() {
          list[index] = true;
        });
      ;
    }
  }

  var recentMsg = '';

  var user;

  List<bool> list = [];

  collection2(String receiver, int index) async {
    user = await FirebaseAuth.instance.currentUser;
    print('here 2');
    final snapshot = await FirebaseFirestore.instance
        .collection('$receiver${user.email}')
        .get();
    print(snapshot.size);
    if (snapshot.size != 0) {
      _getUnreadCount('$receiver${user.email}', index);
      recentMsg = (await FirebaseFirestore.instance
          .collection('$receiver${user.email}')
          .snapshots()
          .last) as String;
      setState(() {
        recentMsg;
      });
    } else {
      _getUnreadCount('${user.email}$receiver', index);
      recentMsg = (await FirebaseFirestore.instance
          .collection('${user.email}$receiver')
          .snapshots()
          .last) as String;
      setState(() {
        recentMsg;
      });
    }
    print('here 2.3');
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return ListView.builder(
            // reverse: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              for (var i = 0;
                  i < double.parse(snapshot.data!.docs.length.toString());
                  i++) {
                list.add(false);
              }
              collection2(snapshot.data!.docs[index]['email'], index);
              if (snapshot.data!.docs[index]['email'] !=
                  FirebaseAuth.instance.currentUser!.email) {
                // collection2(snapshot.data!.docs[index]['email']);
                return Container(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      '${snapshot.data!.docs[index]['first name']} ${snapshot.data!.docs[index]['last name']}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    trailing: list[index]
                        ? Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 12,
                          )
                        : null,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Chat(
                          receiverEmail: snapshot.data!.docs[index]['email'],
                          name:
                              '${snapshot.data!.docs[index]['first name']} ${snapshot.data!.docs[index]['last name']}',
                        );
                      }));
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}
