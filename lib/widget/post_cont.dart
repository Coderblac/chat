import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/post_model.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      // color: Colors.amber,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostHeader(post: post),
                const SizedBox(
                  height: 4,
                ),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: 6,
                      ),
              ],
            ),
          ),
          post.imageUrl != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CachedNetworkImage(imageUrl: post.imageUrl),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _PostState(post: post),
          ),
          const Divider(
            color: Colors.white,
            thickness: 0.1,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${post.likes} Likes',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      '${post.comments} Comments',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '${post.caption} ',
                    style: TextStyle(color: Colors.grey.shade200),
                  ),
                ),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(
                        height: 6,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  final Post post;
  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.user.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(
                    '${post.timeAgo}',
                    style: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.white.withOpacity(0.6),
                    size: 12,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () => print('more'),
            icon: const Icon(Icons.more_horiz, color: Colors.white))
      ],
    );
  }
}

class _PostState extends StatelessWidget {
  final Post post;
  const _PostState({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _PostBtn(
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
                // label: 'Like',
                onTap: () => print('Liked'),
              ),
              _PostBtn(
                icon: const Icon(
                  MdiIcons.commentOutline,
                  color: Colors.white,
                ),
                // label: 'Comment',
                onTap: () => print('comment'),
              ),
              _PostBtn(
                icon: const Icon(
                  MdiIcons.shareOutline,
                  color: Colors.white,
                ),
                // label: 'Share',
                onTap: () => print('share'),
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
          ),
          _PostBtn(
            icon: const Icon(
              Icons.bookmark_outline,
              color: Colors.white,
            ),
            // label: 'Like',
            onTap: () => print('Saved to favorites'),
          ),
        ],
      ),
      // const Divider(),
      // const Icon(
      //   Icons.favorite,
      //   color: Colors.white,
      // ),
      // SizedBox(
      //   width: 4,
      // ),
      // Expanded(
      //   child: Text(
      //     '${post.likes}',
      //     style: TextStyle(color: Colors.grey.shade200),
      //   ),
      // ),
      // Text(
      //   '${post.comments} Comments',
      //   style: TextStyle(color: Colors.grey.shade200),
      // ),
      // SizedBox(
      //   width: 8,
      // ),
      // Text(
      //   '${post.shares} Shared',
      //   style: TextStyle(color: Colors.grey.shade200),
      // ),
    );
  }
}

class _PostBtn extends StatelessWidget {
  final Icon icon;
  // final String label;
  final Function()? onTap;
  const _PostBtn(
      {super.key,
      // required this.label,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 25,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 4),
              // Text(
              //   label,
              //   style: TextStyle(color: Colors.grey.shade200),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
