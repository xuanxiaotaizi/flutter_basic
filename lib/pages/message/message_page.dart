import 'package:appdemo/common/ui/style.dart';
import 'package:appdemo/model/message_model.dart';
import 'package:appdemo/pages/message/category_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class MessagePage extends StatefulWidget{
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation:0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: (){}
        ),
        
        centerTitle: true,
        title: Text(
          'message',
          style: TextStyle(
            fontSize:RjStyle.f16,
            color: Colors.white
          ),
        ),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          onPressed: (){}
          ),
        ],
      ),
      body: Column(
        children:<Widget>[
          CategorySelector(),
          Expanded(
            child:Container(
              decoration:BoxDecoration(
                color:Theme.of(context).accentColor,
                borderRadius:BorderRadius.only(
                topLeft:Radius.circular(RjStyle.size30),
                topRight: Radius.circular(RjStyle.size30)
                )
              ),
              child: Column(
                children:<Widget>[
                  Padding(
                    padding:EdgeInsets.symmetric(
                      horizontal:RjStyle.space20
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Text(
                          'Favorite Contacts',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize:RjStyle.f20
                          ),
                        ),
                        IconButton(
                          iconSize: RjStyle.size30,
                          color: Colors.blueGrey,
                          icon: Icon(Icons.more_horiz), 
                          onPressed: (){}
                        )
                      ]
                    )
                  ),
                  Container(
                    height:RjStyle.size120,
                    child:ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:favorites.length,
                      itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:RjStyle.space10,
                          ),
                          child:Column(
                            children:<Widget>[
                              CircleAvatar(
                                radius:RjStyle.size40,
                                backgroundImage: AssetImage(favorites[index].imageUrl),
                              ),
                              Text(
                                favorites[index].name,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: RjStyle.f16
                                ),
                              )
                            ]
                          )
                        );
                      }
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius:BorderRadius.only(
                        topLeft:Radius.circular(RjStyle.size30),
                        topRight: Radius.circular(RjStyle.size30)
                        )
                      ),
                      child: ListView.builder(
                        itemCount:chats.length,
                        itemBuilder: (BuildContext context,int index){
                          final Message chat = chats[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  user: chat.sender,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: RjStyle.space10
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  CircleAvatar(
                                    radius: RjStyle.space30,
                                    backgroundImage: AssetImage(chat.sender.imageUrl),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:<Widget>[
                                      Text(
                                        chat.sender.name,
                                        style:TextStyle(
                                          color:Colors.black45,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Container(
                                        width:RjStyle.screenWidth*0.45,
                                        child:Text(
                                          chat.text,
                                          style: TextStyle(
                                            color:Colors.blueGrey
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      )
                                    ]
                                  ),
                                  Text(
                                    chat.time,
                                    style:TextStyle(
                                      color:Colors.black45,
                                      fontSize: RjStyle.f16,
                                      fontWeight: FontWeight.bold
                                    )
                                  )
                                ]
                              ),
                            )
                          ); 
                        },
                      ),
                    )
                  )
                ]
              ),
            )
          )
        ]
      ),
    );
  }
}