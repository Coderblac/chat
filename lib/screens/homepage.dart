import 'package:chatapp/data/data.dart';
import 'package:chatapp/models/models.dart';
import 'package:chatapp/widget/bottom_navbar.dart';
import 'package:chatapp/widget/circle_btn.dart';
import 'package:chatapp/widget/stories.dart';
import 'package:flutter/material.dart';
import '../widget/create_post.dart';
import '../widget/post_cont.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 19, 26, 1),
      bottomNavigationBar: Nav(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Color.fromRGBO(18, 19, 26, 1),
            title: const Text(
              'ChatApp',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.2),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              CirleBtn(
                  icon: Icons.more_vert,
                  iconsize: 30,
                  onpressed: () => print('search')),
              // CirleBtn(
              //     icon: MdiIcons.chatPlus,
              //     iconsize: 30,
              //     onpressed: () => print('messenger')),
            ],
          ),
          SliverToBoxAdapter(
            child: CreatePostContainer(currentUser: currentUser),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            sliver: SliverToBoxAdapter(
              child: Stories(currentUser: currentUser, stories: stories),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final Post post = posts[index];
                return PostContainer(post: post);
              },
              childCount: posts.length,
            ),
          )
        ],
      ),
    );
  }
}
