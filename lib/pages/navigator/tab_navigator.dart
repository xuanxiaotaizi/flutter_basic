
import 'package:appdemo/common/screen_adaptation.dart';
import 'package:appdemo/pages/flare/flare_page.dart';
import 'package:appdemo/pages/list/list_page.dart';
import 'package:appdemo/pages/message/session_page.dart';
import 'package:appdemo/pages/motion/motion_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.red;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    ScreenAdaptation.instance = ScreenAdaptation()..init(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          MotionPage(),
          ListPage(),
          SessionPage(),
          FlarePage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.grey,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(Icons.add, size: 15),
          Icon(Icons.list, size: 15),
          Icon(Icons.compare_arrows, size: 15),
          Icon(Icons.question_answer,size:15)
        ]
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }
}
