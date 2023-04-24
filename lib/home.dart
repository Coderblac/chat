import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingController = TextEditingController();
  late User _currentUser;
  late Stream<QuerySnapshot> _chats;

  @override
  void initState() {
    super.initState();
    _getUser();
    _chats = _firestore
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _getUser() async {
    User? user = await _auth.currentUser;
    setState(() {
      _currentUser = user!;
    });
  }

  void _sendMessage(String text) async {
    if (text.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(DateTime.now().toString())
          .set({
        'text': text,
        'sender': 'barry',
        'timestamp': DateTime.now(),
        // .millisecondsSinceEpoch,
        'senderPhotoUrl': 'url',
        'senderName': 'barry'
      });
      _textEditingController.clear();
    }
  }

  Widget _buildChatItem(QueryDocumentSnapshot document) {
    Size size = MediaQuery.of(context).size;
    String Sender_info = document.get('sender');
    String imgurl = document.get('senderPhotoUrl');

    String senderName = document.get('senderName');

    String text = document.get('text');

    // bool isMe = Sender_info == _currentUser.uid;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // isMe ? SizedBox() : CircleAvatar(),
          SizedBox(width: 8.0),
          Expanded(
            child: senderName == 'barry'
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(1),
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          text,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(1),
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          text,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ),
          // isMe
          //     ? SizedBox()
          //     : IconButton(
          //         icon: Icon(Icons.favorite_border),
          //         onPressed: () {},
          //       ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('chats').snapshots(),
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
                    return _buildChatItem(snapshot.data!.docs[index]);
                  },
                );
              },
            ),
          ),
          Container(
            width: size.width,
            color: Colors.grey[100],
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.photo),
                Expanded(
                  child: CupertinoTextField(
                    controller: _textEditingController,
                    placeholder: 'Type a message',
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () async =>
                      _sendMessage(_textEditingController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
