import 'package:appdemo/common/style.dart';
import 'package:appdemo/model/bubble_model.dart';
import 'package:appdemo/pages/message/bubble_voice.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
   bool isOn = false;
  final Bubble bubble;
  ChatBubble({this.bubble});
  @override
  Widget build(BuildContext context) {
    switch (bubble.type) {
      case 1:
        return _voice(bubble);
        break;
      default:
    }
  }
  _voice(Bubble bubble){
    var widget =_voiceBar();
    return _me(widget);
  }
  _voiceBar(){
     return BubbleVoice(seconds: 20);
  }

  _me(Widget widget){
    return Container(
      margin: EdgeInsets.only(bottom:Style.size30),
      child: Row(
      mainAxisAlignment:MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left:Style.size10,
                    right: Style.size10,
                    top: Style.size4,
                    bottom: Style.size4
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: Style.size10
                  ),
                  constraints: BoxConstraints(
                    minWidth: Style.screenWidth * 0.2,
                    minHeight: Style.size32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Style.size30),
                      topRight: Radius.circular(Style.size30),
                      bottomLeft: Radius.circular(Style.size30),
                      bottomRight: Radius.circular(Style.size4),
                    )
                  ),
                  
                  child: widget
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left:Style.size8),
              child: SizedBox(
                width: Style.size30,
                height: Style.size30,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(bubble.user.imageUrl),
                ),
              ),
            ),
          ],
        )
      ]
    ),
    ); 
  }
  _other(Widget widget){
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right:Style.size8),
          child: SizedBox(
            width: Style.size30,
            height: Style.size30,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(bubble.user.imageUrl),
            ),
          ),
        ),
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                bubble.user.name,
                style: TextStyle(
                  fontSize: Style.size10,
                ),
              ),
            ),
            widget
          ],
        )
      ],
    );
  }

  _text(Bubble bubble){
    Widget me = Container(
      padding: EdgeInsets.all(Style.size8),
      margin: EdgeInsets.symmetric(
        vertical: Style.size10
      ),
      constraints: BoxConstraints(
        maxWidth: Style.screenWidth * 0.6,
        minHeight: Style.size30,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Style.size12),
          bottomRight: Radius.circular(Style.size12),
        )
      ),
      
      child: Text(
        bubble.body,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
    Widget other = Container(
      padding: EdgeInsets.all(Style.size10),
      margin: EdgeInsets.symmetric(
        vertical: Style.size10
      ),
      constraints: BoxConstraints(
        maxWidth: Style.screenWidth * 0.6,
        minHeight: Style.size30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Style.size12),
          bottomLeft: Radius.circular(Style.size12)
        )
      ),
      
      child: Text(
        bubble.body,
        style: TextStyle(
          color: Colors.blue
        ),
      ),
    ); 
    return Align(
      alignment:bubble.isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: bubble.isSelf ? _me(me) : _other(other),
    );
  }
}