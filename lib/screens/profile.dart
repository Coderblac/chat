import 'dart:io';
import 'package:chatapp/widget/profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../data/data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final user = FirebaseAuth.instance.currentUser ?? '';
  String imageUrl = '';

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
      'name': 'Change Profile Photo',
      'icon': Icon(MdiIcons.camera, color: Colors.white)
    },
    {'name': 'List', 'icon': Icon(Icons.list_outlined, color: Colors.white)},
    {'name': 'Topics', 'icon': Icon(Icons.topic_outlined, color: Colors.white)},
    {
      'name': 'Bookmarks',
      'icon': Icon(Icons.bookmark_outlined, color: Colors.white)
    },
    {'name': 'Moments', 'icon': Icon(Icons.star_outline, color: Colors.white)},
    {
      'name': 'Settings and Privacy',
      'icon': Icon(Icons.settings_outlined, color: Colors.white)
    },
    {
      'name': 'Help Center',
      'icon': Icon(Icons.help_center_outlined, color: Colors.white)
    },
    {'name': 'LogOut', 'icon': Icon(Icons.logout, color: Colors.white)},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 26, 1),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(18, 19, 26, 1),
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
              onTap: () {},
              child: Icon(
                Icons.notifications,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      ProfileAvatar(imageUrl: currentUser.imageUrl),
                      Row(
                        children: [
                          // Text(
                          //   FirebaseAuth.instance.currentUser!.email.toString(),
                          //   style:
                          //       TextStyle(color: Colors.white.withOpacity(0.8)),
                          // ),
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
            Container(
              margin: EdgeInsets.zero,
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: drawerItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      minVerticalPadding: 0,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      title: Text(
                        drawerItems[index]['name'],
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: drawerItems[index]['icon'],
                      trailing: Icon(
                        Icons.arrow_right_outlined,
                        color: Colors.white,
                      ),
                      onTap: () async {
                        if (index == 0) {
                          showModalBottomSheet(
                              context: context,
                              builder: ((context) => buildsheet()));
                        } else if (index == 1) {
                        } else if (index == 2) {
                        } else if (index == 3) {
                        } else if (index == 4) {
                        } else if (index == 5) {
                        } else if (index == 6) {
                        } else if (index == 7) {
                          FirebaseAuth.instance.signOut();
                        }
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildsheet() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  print('${file?.path}');

                  if (file == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  // get storage ref

                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                  //  create ref for the image to be stored

                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);

                  // handle error/success

                  try {
                    // store the file
                    await referenceImageToUpload.putFile(File(file.path));
                    // success: get download url
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  } catch (error) {
                    // some error occured
                  }

                  //
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.pink,
                      ),
                      Text('Camera')
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  if (file == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  // get storage ref

                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images');

                  //  create ref for the image to be stored

                  Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);

                  // handle error/success

                  try {
                    // store the file
                    await referenceImageToUpload.putFile(File(file.path));
                    // success: get download url
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  } catch (error) {
                    // some error occured
                  }

                  //
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.green,
                      ),
                      Text('Photos')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
