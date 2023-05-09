import 'package:chatapp/widget/profile_avatar.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;
  const CreatePostContainer({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      color: Color.fromRGBO(18, 19, 26, 1),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(imageUrl: currentUser.imageUrl),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Share your thought',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.4)),
                  ),
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 10.0,
            thickness: 0.0,
          ),
          Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => print('Live'),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.videocam,
                        color: Colors.red,
                      ),
                      Text(
                        'Live',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 8,
                  thickness: 0.0,
                ),
                InkWell(
                  onTap: () => print('Photo'),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.photo,
                        color: Colors.green,
                      ),
                      Text(
                        'Photo',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade600,
                  width: 8,
                ),
                InkWell(
                  onTap: () => print('Room'),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.video_call,
                        color: Colors.purpleAccent,
                      ),
                      Text(
                        'Room',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
