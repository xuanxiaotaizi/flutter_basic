import 'dart:async';

import 'package:appdemo/common/ui/style.dart';
import 'package:appdemo/model/message_model.dart';
import 'package:appdemo/model/user_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  ChatScreen({this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _controller = ScrollController();
  @override
    void initState(){
      super.initState();
      nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) {
        print('失去焦点');
      }else{
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
  static String inputText = "";
   TextEditingController _message = TextEditingController.fromValue(
                TextEditingValue(
                  // 设置内容
                  text: inputText,
                  // 保持光标在最后
                  selection: TextSelection.fromPosition(
                    TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: inputText.length
                    )
                  )
                  ));
                  FocusNode nameFocusNode = FocusNode();
  _buildMessage(Message message,bool isMe){
    return Align(
      alignment: isMe ? Alignment.centerRight :Alignment.centerLeft,
      child:Container(
        constraints: BoxConstraints(
          maxWidth: RjStyle.screenWidth*0.6,
          minHeight: 50,
        ),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          borderRadius: isMe ? BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ): BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        padding: EdgeInsets.all(RjStyle.space12),
        margin: EdgeInsets.only(
          top:RjStyle.size8,
          bottom:RjStyle.size8
        ),
        child: Text(message.text),
      )
    );
  }

  _buildMessageComposer(){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:RjStyle.space8
      ),
      height: RjStyle.size80,
      color: Colors.white,
      child: Row(
        children:<Widget>[
          IconButton(
            icon:Icon(Icons.photo),
            iconSize: RjStyle.f24,
            color: Theme.of(context).primaryColor,
            onPressed: (){},
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                this.setState(() {
                  inputText = value;
                });
              },
              controller:_message,
              focusNode: nameFocusNode,
              decoration: InputDecoration.collapsed(
                hintText: 'Send message',
              ),
            ),
          ),
          IconButton(
            icon:Icon(Icons.send),
            iconSize: RjStyle.f24,
            color: Theme.of(context).primaryColor,
            onPressed: (){
              print(inputText);
              if(inputText!=""){
                 messages.insert(
                    0,
                    Message(
                      sender: currentUser,
                      time: '5:30 PM',
                      text: this._message.text,
                      isLiked: false,
                      unread: true,
                    ),
                  );
                  this._message.clear();
                setState(() {});
              }
            },
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), 
            color: Colors.white,
            onPressed: (){
              Navigator.pop(context);
            }
          ),
          title: Text(
            widget.user.name,
            style: TextStyle(
              color:Colors.white
            ),
          ),
          actions: <Widget>[
            IconButton(
            icon: Icon(Icons.more_horiz),
            color: Colors.white,
            onPressed: (){}
            ),
          ],
        ),
        body:Column(
          children:<Widget>[
            Expanded(
              child: Container(
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.only(
                    topLeft:Radius.circular(RjStyle.size30),
                    topRight:Radius.circular(RjStyle.size30)
                  )
                ),
                child:ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(RjStyle.size30),
                    topRight: Radius.circular(RjStyle.size30)
                  ),
                  child: ListView.builder(
                    controller: _controller,
                    reverse: true,
                    padding: EdgeInsets.only(
                      top:RjStyle.size16
                    ),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index){
                      final Message message = messages[index];
                      bool isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message,isMe);
                    }
                  ),
                )
              ), 
            ),
            _buildMessageComposer()
          ]
        ) 
      )
    ); 
  }
}