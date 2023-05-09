
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final String receiverEmail;
  final String name;

  Chat({required this.receiverEmail, required this.name});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingController = TextEditingController();
  late User _currentUser;
  late Stream<QuerySnapshot> _chats;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // _getUser();
    _checkChat();
    collection();
    collection2();
    void _getUnreadCount() async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('messages')
          .where('read', isEqualTo: false)
          .get();
    }

    print(collectiionName);

    _chats = _firestore
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  collection() async {
    user = await FirebaseAuth.instance.currentUser;
    print('here 1');
    final snapshot = await FirebaseFirestore.instance
        .collection('${user!.email}${widget.receiverEmail}')
        .get();
    if (snapshot.size != 0)
      setState(() {
        collectiionName = '${user.email}${widget.receiverEmail}';
        isLoading = false;
      });
    print('here 1.3');
    return;
  }

  collection2() async {
    user = await FirebaseAuth.instance.currentUser;
    print('here 2');
    final snapshot = await FirebaseFirestore.instance
        .collection('${widget.receiverEmail}${user!.email}')
        .get();
    print(snapshot.size);
    if (snapshot.size != 0)
      setState(() {
        collectiionName = '${widget.receiverEmail}${user.email}';
        isLoading = false;
      });
    print('here 2.3');
    return;
  }

  var user;
  String collectiionName = '';
  _checkChat() async {
    user = await FirebaseAuth.instance.currentUser;

    collectiionName = '${user.email}${widget.receiverEmail}';
    setState(() {
      isLoading = false;
    });
    return;
  }

  // void _getUser() async {
  //   User? user = await _auth.currentUser;
  //   setState(() {
  //     _currentUser = user!;
  //   });
  // }

  void _sendMessage(String text) async {
    if (text.trim().isNotEmpty) {
      _textEditingController.clear();
      await FirebaseFirestore.instance
          .collection(collectiionName)
          .doc(DateTime.now().toString())
          .set({
        'text': text,
        'sender': 'nnnn',
        'timestamp': DateTime.now(),
        'senderPhotoUrl': 'url',
        'senderName': user.email,
        'receiver': widget.receiverEmail,
        'read': false
      });
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
            child: senderName == user.email
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(18, 19, 26, 1),
                            // border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
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
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(58, 58, 74, 1),
                            // border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )),
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
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
      backgroundColor: Color.fromRGBO(106, 106, 133, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 19, 26, 1),
        title: Text(
          widget.name,
          style: TextStyle(
            color: Color.fromRGBO(165, 165, 192, 1),
          ),
        ),
        iconTheme: IconThemeData(color: Color.fromRGBO(89, 89, 114, 1)),
        elevation: 0.3,
      ),
      body: isLoading
          ? Container(
              color: Color.fromRGBO(18, 19, 26, 1),
              height: size.height,
              width: size.width,
              child: Center(child: CupertinoActivityIndicator()))
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(collectiionName)
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
                          return _buildChatItem(snapshot.data!.docs[index]);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(40)),
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(18, 19, 26, 1),
                            child: Icon(
                              Icons.photo_outlined,
                              color: Colors.white,
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            // placeholder: 'Message...',
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ('Message...'),
                            ),
                            onSubmitted: _sendMessage,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Color.fromRGBO(18, 19, 26, 1),
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
