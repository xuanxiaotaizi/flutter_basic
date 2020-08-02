import 'package:appdemo/pages/navigator/tab_navigator.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.navigate(
      backgroundColor: Colors.red,
      name: 'assets/flare/penguin_nodding.flr',
      next: (context) => TabNavigator(),
      until: () => Future.delayed(Duration(seconds: 5)),
      startAnimation: 'music_walk',
      loopAnimation:'music_walk'
    );
  }
}