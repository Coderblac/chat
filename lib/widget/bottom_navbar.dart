import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/homepage.dart';
import '../screens/profile.dart';
import '../user pages/chat_list.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentIndex = 0;
  late List<Widget> screens;
  bool showAppBar = true;

  @override
  void initState() {
    screens = [
      HomePage(),
      ChatList(),
      ChatList(),
      Profile(),
    ];
    super.initState();
  }

  changeNavbar(int index) {
    setState(() {
      currentIndex = index;
      HapticFeedback.lightImpact();
      if (currentIndex == 0) {
        showAppBar = true;
      } else {
        showAppBar = false;
      }
      if (currentIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ChatList();
        }));
      }
      if (currentIndex == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ChatList();
        }));
      }
      if (currentIndex == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const Profile();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(
          vertical: size.width * .05, horizontal: size.width * 0.08),
      height: size.width * .155,
      decoration: BoxDecoration(
        color: Color.fromRGBO(18, 19, 26, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
        itemBuilder: (context, index) => InkWell(
          onTap: () => changeNavbar(index),
          splashColor: Colors.transparent,
          highlightColor: Colors.white,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width:
                    index == currentIndex ? size.width * .18 : size.width * .18,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == currentIndex ? size.width * .12 : 0,
                  width: index == currentIndex ? size.width * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? Colors.white
                        : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width:
                    index == currentIndex ? size.width * .18 : size.width * .18,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex ? size.width * .13 : 0,
                        ),
                        AnimatedOpacity(
                          opacity: index == currentIndex ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Text(
                            index == currentIndex ? listOfStrings[index] : '',
                            style: const TextStyle(
                              color: Colors.transparent,
                              fontWeight: FontWeight.w600,
                              fontSize: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex ? 20 : 20,
                        ),
                        Icon(listOfIcons[index],
                            size: size.width * .076,
                            color: index == currentIndex
                                ? Color.fromRGBO(18, 19, 26, 1)
                                : Colors.grey.shade400),
                      ],
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

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.search,
    MdiIcons.chat,
    Icons.person_rounded,
  ];

  List<String> listOfStrings = [
    'home',
    'Search',
    'Chat',
    'Profile',
  ];
}
