import 'package:chatapp/config/palette.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/user_model.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;
  const Rooms({super.key, required this.onlineUsers});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            scrollDirection: Axis.horizontal,
            itemCount: 1 + onlineUsers.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _CreateRoomBtn(),
                );
              }
              final User user = onlineUsers[index - 1];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ProfileAvatar(
                  imageUrl: user.imageUrl,
                  isActive: true,
                ),
              );
            }));
  }
}

class _CreateRoomBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white.withOpacity(0.05),
      ),
      child: OutlinedButton(
        onPressed: () => print('Create Room'),
        child: Row(
          children: [
            ShaderMask(
              shaderCallback: (rect) =>
                  Palette.createRoomGradient.createShader(rect),
              child: Icon(
                Icons.video_call,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text('Create\nRoom')
          ],
        ),
      ),
    );
  }
}
