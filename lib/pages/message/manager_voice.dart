import 'package:appdemo/common/style.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class VoiceManager extends StatefulWidget {
  @override
  _VoiceManagerState createState() => _VoiceManagerState();
}

class _VoiceManagerState extends State<VoiceManager> {
  bool isPaused = true;
  int recordTime = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details)=>{
        isPaused = false,
        setState((){})
      },
      onTapUp: (details)=>{
        isPaused = true,
        setState((){})
      },
      onLongPressUp: ()=>{
        isPaused = true,
        setState((){})
      },
      onLongPressMoveUpdate:(details)=>{
        if(details.offsetFromOrigin.dy < -50){
          isPaused = true,
          setState((){})
        }
      },
      child: Wrap(
        children: [
          Container(
            width:Style.screenWidth/60*recordTime,
            height:2,
            color: Colors.blue,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                top: Style.size30
              ),
              child: Text(
                "上划取消 ${recordTime}s",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
            ),
          ),
         
          Center(
            child:Container(
              alignment: Alignment.center,
              width:Style.size150,
              height:Style.size200,
              child:FlareActor(
                'assets/flare/voiceing.flr',
                animation: 'analysis',
                isPaused: isPaused,
              ),
            )
          )
          
        ],
      ),
    );
  }
}