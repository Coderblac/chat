import 'package:chatapp/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 19, 26, 1),
        title: Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Messages',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(165, 165, 192, 1),
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                width: size.width * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        child: Icon(
                      Icons.search,
                      color: Color.fromRGBO(165, 165, 192, 1),
                    )),
                    InkWell(
                        child: Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(165, 165, 192, 1),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(165, 165, 192, 1),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Color.fromRGBO(18, 19, 26, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            'Recent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: size.height * .9,
                        width: size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            if (!snapshot.hasData)
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            return ListView.builder(
                              // reverse: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                for (var i = 0;
                                    i <
                                        double.parse(snapshot.data!.docs.length
                                            .toString());
                                    i++) {
                                  list.add(false);
                                }
                                collection2(
                                    snapshot.data!.docs[index]['email'], index);
                                if (snapshot.data!.docs[index]['email'] !=
                                    FirebaseAuth.instance.currentUser!.email) {
                                  // collection2(snapshot.data!.docs[index]['email']);
                                  return Column(
                                    children: [
                                      Container(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          title: Text(
                                            '${snapshot.data!.docs[index]['first name']} ${snapshot.data!.docs[index]['last name']}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          trailing: list[index]
                                              ? Icon(
                                                  Icons.circle,
                                                  color: Colors.blue,
                                                  size: 12,
                                                )
                                              : null,
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return Chat(
                                                receiverEmail: snapshot
                                                    .data!.docs[index]['email'],
                                                name:
                                                    '${snapshot.data!.docs[index]['first name']} ${snapshot.data!.docs[index]['last name']}',
                                              );
                                            }));
                                          },
                                        ),
                                      ),
                                      // SizedBox(
                                      //     width: size.width * 0.7,
                                      //     child: Divider(
                                      //       color: Colors.black,
                                      //     ))
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List contacts = [
    {'name': 'barry'},
    {'name': 'Ekene'}
  ];
}
