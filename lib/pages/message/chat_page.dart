import 'dart:async';

import 'package:appdemo/common/iconfont.dart';
import 'package:appdemo/common/style.dart';
import 'package:appdemo/model/bubble_model.dart';
import 'package:appdemo/model/user_model.dart';
import 'package:appdemo/pages/message/chat_bubble.dart';
import 'package:appdemo/pages/message/manager_voice.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User user;
  ChatPage({this.user});
  @override
  _ChatPageState createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  ScrollController _controller = ScrollController();
  static String inputText = "";
  double managerHeight = 0;
  String managerType = '';
  TextEditingController _message = TextEditingController.fromValue(
    TextEditingValue(
      // 设置内容
      text: inputText,
      // 保持光标在最后
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream, 
          offset: inputText.length
        ),
      ),
    ),
  );
  FocusNode nameFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    nameFocusNode.addListener(() {
      managerHeight = 0;
      setState(() {});
      if (!nameFocusNode.hasFocus) {
        print('失去焦点');
      } else {
        _controller.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  @override
  void dispose() {
    nameFocusNode.unfocus();
    super.dispose();
  }
  
  _buildManager(type){
    switch (type) {
      case 'voice' :
        return VoiceManager();
      break;
      default:
    }
  }
  _bulidBottom(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  this.setState(() {
                    inputText = value;
                  });
                },
                focusNode: nameFocusNode,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(Style.size8),
                  hintText: 'Send message',
                  disabledBorder: InputBorder.none,
                  enabledBorder:  InputBorder.none,
                  focusedBorder:   InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Iconfont.Iconjinyong1),
              iconSize: Style.size30,
              color: Colors.blue,
              onPressed: () {
                print(inputText);
              }
            )
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Iconfont.Iconyuyin),
                iconSize: Style.size30,
                color: Colors.blue,
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    managerHeight = Style.size300;
                    managerType = 'voice';
                  });
                }
              ),
              IconButton(
                icon: Icon(Iconfont.Iconshipin),
                iconSize: Style.size30,
                color: Colors.blue,
                onPressed: () {
                  print(inputText);
                }
              ),
              IconButton(
                icon: Icon(Iconfont.Icontupian),
                iconSize: Style.size30,
                color: Colors.blue,
                onPressed: () {
                  print(inputText);
                }
              ),
              IconButton(
                icon: Icon(Iconfont.Iconbiaoqing),
                iconSize: Style.size30,
                color: Colors.blue,
                onPressed: () {
                  print(inputText);
                }
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: Style.screenWidth,
          height: managerHeight,
          child: _buildManager(managerType),
          onEnd: ()=>{},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    Bubble bubble = new Bubble.init(1, 12312312, widget.user , 'asdasda');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          title: Text(widget.user.name),
        ),
        body:GestureDetector(
          onTap: ()=>{
            managerHeight = 0,
            setState((){})
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Style.size10
                  ),
                  color: Style.gery,
                  child: ListView.builder(
                    controller: _controller,
                    reverse: true,
                    padding: EdgeInsets.only(top: Style.size16),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatBubble(bubble: bubble);
                    }
                  ),
                ),
              ),
              _bulidBottom()
            ],
          ),
        ) 
      ),
    );
  }
}