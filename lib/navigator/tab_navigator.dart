
import 'package:appdemo/common/ui/screen_adaptation.dart';
import 'package:appdemo/pages/channel/channel_page.dart';
import 'package:appdemo/pages/find/find_page.dart';
import 'package:appdemo/pages/message/message_page.dart';
import 'package:appdemo/pages/my/my_page.dart';
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
          FindPage(),
          ChannelPage(),
          MessagePage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem('motion', Icons.ac_unit, 0),
            _bottomItem('list', Icons.account_circle, 1),
            _bottomItem('message', Icons.message, 2),
            _bottomItem('video', Icons.video_call, 3),
          ]),
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
