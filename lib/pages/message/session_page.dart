import 'package:animations/animations.dart';
import 'package:appdemo/common/style.dart';
import 'package:appdemo/model/message_model.dart';
import 'package:appdemo/model/user_model.dart';
import 'package:appdemo/pages/message/chat_page.dart';
import 'package:flutter/material.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '消息',
          style: TextStyle(fontSize: Style.size20, color: Colors.black),
        ),
      ),
      body: Container(
        child:ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context,int index){
             final Message chat = chats[index];
            return _buildSessionItem(chat);
          },
        )
      ),
    );
  }
  _buildSessionItem(Message chat){
    User user = chat.sender;
    return OpenContainer(
      transitionDuration: Duration(milliseconds:800),
      openBuilder: (BuildContext context,VoidCallback _){
        return ChatPage(user:user);
      },
      closedBuilder: (BuildContext context,VoidCallback openContainer){
        return Container(
            padding: EdgeInsets.symmetric(
              horizontal: Style.size20, 
              vertical: Style.size16
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5
                        ),
                      ]
                    ),
                  child: SizedBox(
                    width: Style.size60,
                    height: Style.size60,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(chat.sender.imageUrl),
                    ),
                  ),
                ),
                
                Container(
                  width: Style.screenWidth*0.65,
                  child:  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom:Style.size10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right:10),
                                  child: Text(
                                    chat.sender.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Style.size16
                                    ),
                                  ),
                                ),
                                
                                ClipOval(
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              chat.time,
                              style: TextStyle(fontSize: Style.size16),
                            ),
                          ]
                        ),
                      ),
                      
                      Text(
                        chat.text,
                        style: TextStyle(
                          fontSize: Style.size16,
                          color: Colors.grey
                        ),
                      ),
                    ],
                  )
                ),

            ]),
          );
      },
    ); 
  }
}
