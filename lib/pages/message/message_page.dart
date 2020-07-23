import 'package:appdemo/common/style.dart';
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
            fontSize:Style.size16,
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
                topLeft:Radius.circular(Style.size30),
                topRight: Radius.circular(Style.size30)
                )
              ),
              child: Column(
                children:<Widget>[
                  Padding(
                    padding:EdgeInsets.symmetric(
                      horizontal:Style.size20
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                        Text(
                          'Favorite Contacts',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize:Style.size20
                          ),
                        ),
                        IconButton(
                          iconSize: Style.size30,
                          color: Colors.blueGrey,
                          icon: Icon(Icons.more_horiz), 
                          onPressed: (){}
                        )
                      ]
                    )
                  ),
                  Container(
                    height:Style.size100,
                    child:ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:favorites.length,
                      itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:Style.size10,
                          ),
                          child:Column(
                            children:<Widget>[
                              CircleAvatar(
                                radius:Style.size40,
                                backgroundImage: AssetImage(favorites[index].imageUrl),
                              ),
                              Text(
                                favorites[index].name,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: Style.size16
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
                        topLeft:Radius.circular(Style.size30),
                        topRight: Radius.circular(Style.size30)
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
                                vertical: Style.size10
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  CircleAvatar(
                                    radius: Style.size30,
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
                                        width:Style.screenWidth*0.45,
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
                                      fontSize: Style.size16,
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