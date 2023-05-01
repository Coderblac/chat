import 'package:chatapp/bottom_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // document IDs

  List<String> docIDs = [];

  // get docIDs

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            (document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  List drawerItems = [
    {
      'name': 'Profile',
      'icon': Icon(Icons.person_outline, color: Colors.black)
    },
    {'name': 'List', 'icon': Icon(Icons.list_outlined, color: Colors.black)},
    {'name': 'Topics', 'icon': Icon(Icons.topic_outlined, color: Colors.black)},
    {
      'name': 'Bookmarks',
      'icon': Icon(Icons.bookmark_outlined, color: Colors.black)
    },

    {'name': 'Moments', 'icon': Icon(Icons.star_outline, color: Colors.black)},
    {
      'name': 'Settings and Privacy',
      'icon': Icon(Icons.settings_outlined, color: Colors.black)
    },
    {
      'name': 'Help Center',
      'icon': Icon(Icons.help_center_outlined, color: Colors.black)
    },
    // {'name': 'LogOut', 'icon': Icon(Icons.logout, color: Colors.black)},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Nav(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       begin: Alignment.topRight,
            //       end: Alignment.bottomLeft,
            //       stops: [
            //         0.0,
            //         1.0
            //       ],
            //       colors: [
            //         Colors.grey,
            //         Colors.white,
            //       ]),
            // ),
            padding: EdgeInsets.symmetric(vertical: 5),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.005),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(),
                          Row(
                            children: [
                              Text(FirebaseAuth.instance.currentUser!.email
                                  .toString()),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.blueAccent,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // drawer

                Container(
                  margin: EdgeInsets.zero,
                  height: size.height * 0.52,
                  child: ListView.builder(
                      itemCount: drawerItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minVerticalPadding: 0,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          title: Text(drawerItems[index]['name']),
                          leading: drawerItems[index]['icon'],
                          trailing: Icon(Icons.arrow_right_outlined),
                          onTap: () {
                            if (index == 0) {
                            } else if (index == 1) {
                            } else if (index == 2) {
                            } else if (index == 3) {
                            } else if (index == 4) {
                            } else if (index == 5) {
                            } else if (index == 6) {}
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Icon(
                Icons.logout,
              ),
            ),
          )
        ],
      ),
    );
  }
}
