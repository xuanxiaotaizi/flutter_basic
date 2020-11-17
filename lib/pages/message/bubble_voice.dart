import 'package:appdemo/common/style.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class BubbleVoice extends StatefulWidget {
  int seconds = 0;
  BubbleVoice({this.seconds});
  @override
  _bubbleVoiceState createState() => _bubbleVoiceState();
}

class _bubbleVoiceState extends State<BubbleVoice> {
  bool isPaused = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        print('asdasd'),
        isPaused = !isPaused,
        setState((){})
      },
      child: Container(
        color: Colors.blue,
        width:widget.seconds*5.toDouble(),
        height: Style.size30,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.seconds} "',
              style: TextStyle(
                color:Colors.white
              ),
            ),
            Container(
              width:Style.size20,
              height: Style.size20,
              child:FlareActor(
                'assets/flare/voice.flr',
                isPaused: isPaused,
                animation: 'idle',
              )
            )
          ],
        )
      ) 
    ); 
  }
}