import 'package:chatapp/Chat.dart';
import 'package:chatapp/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  var _selectedIndex = 0;
  var _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
    print(_selectedIndex);
    if (_selectedIndex == 0) {
    } else if (_selectedIndex == 1) {
      // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //   return AwaitingOrders();
      // }
      // ));
    } else if (_selectedIndex == 2) {
    } else if (_selectedIndex == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ChatList();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      // fixedColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail_outline),
          label: 'Message',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[500],
      onTap: _onItemTapped,
    );
  }
}

// const TextStyle optionStyle =
//     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// const List<Widget> _widgetOptions = <Widget>[
//   Text(
//     'Index 0: Home',
//     style: optionStyle,
//   ),
//   Text(
//     'Index 1: Awaiting',
//     style: optionStyle,
//   ),
//   Text(
//     'Index 2: History',
//     style: optionStyle,
//   ),
//   Text(
//     'Index 3: Settings',
//     style: optionStyle,
//   ),
// ];
