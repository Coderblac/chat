import 'package:chatapp/data/data.dart';
import 'package:chatapp/screens/Chat.dart';
import 'package:chatapp/widget/contacts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../config/palette.dart';
import '../widget/circle_btn.dart';
import '../widget/create_post.dart';
import '../widget/rooms.dart';

class ChatList extends StatefulWidget {
  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 26, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(18, 19, 26, 1),
            title: Text(
              'Contacts',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.2),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              CirleBtn(
                  icon: Icons.search,
                  iconsize: 30,
                  onpressed: () => print('search')),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            sliver: SliverToBoxAdapter(
              child: Rooms(onlineUsers: onlineUsers),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 10, 0, 5),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Contacts())
        ],
      ),
    );
  }

  List contacts = [
    {'name': 'barry'},
    {'name': 'Ekene'}
  ];
}
