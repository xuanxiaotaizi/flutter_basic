import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';

class FlarePage extends StatefulWidget{
  @override
  _FlarePageState createState() => _FlarePageState();
}

class _FlarePageState extends State<FlarePage>{
  @override
  Widget build(BuildContext context) {
    var animationWidth = 295.0;
    var animationHeight = 251.0;
    var animationWidthThirds = animationWidth / 3;
    var halfAnimationHeight = animationHeight / 2;
    var activeAreas = [

      ActiveArea(
        area: Rect.fromLTWH(0, 0, animationWidthThirds, halfAnimationHeight),
        debugArea: false,
        guardComingFrom: ['deactivate'],
        animationName: 'camera_tapped',
      ),

      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds, 0, animationWidthThirds, halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'pulse_tapped'),

      ActiveArea(
          area: Rect.fromLTWH(animationWidthThirds * 2, 0, animationWidthThirds, halfAnimationHeight),
          debugArea: false,
          guardComingFrom: ['deactivate'],
          animationName: 'image_tapped'),

      ActiveArea(
          area: Rect.fromLTWH(0, animationHeight / 2, animationWidth, animationHeight / 2),
          debugArea: false,
          animationsToCycle: ['activate', 'deactivate'],
          onAreaTapped: () {
            print('Button tapped!');
          })

    ];

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Flare',style: TextStyle(color:Colors.white),),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SmartFlareActor(
            width: animationWidth,
            height: animationHeight,
            filename: 'assets/flare/button-animation.flr',
            startingAnimation: 'deactivate',
            activeAreas: activeAreas,
          ),
        ),
      ),
    );
  }
}