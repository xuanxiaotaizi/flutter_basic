import 'package:appdemo/model/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChannelPage extends StatefulWidget{
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'list key',
          style: TextStyle(
            color:Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context,int index){
          final item = articles[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(item.text),
              IconButton(
                color: !item.isLike?Colors.blue:Colors.red,
                icon: Icon(Icons.star), 
                onPressed: (){
                   setState(() {
                     item.isLike = !item.isLike;
                   });
                }
              )
            ],
          );
        }
      ),
    );
  }
}