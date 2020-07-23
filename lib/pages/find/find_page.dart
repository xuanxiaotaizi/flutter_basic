import 'package:animations/animations.dart';
import 'package:appdemo/pages/find/detail_page.dart';
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget{
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'motion system',
          style: TextStyle(
            color:Colors.white,
          ),
        ),
      ),
      floatingActionButton:OpenContainer(
        transitionDuration: Duration(milliseconds:1000),
        closedBuilder: (BuildContext context,VoidCallback _){
          return SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        }, 
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        openBuilder: (BuildContext context,VoidCallback _){
          return DetailPage();
        }
      ),
      body: GridView.builder(
        itemCount: 50,
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 4
        ), 
        itemBuilder: (BuildContext context,int index){
          return OpenContainer(
            transitionDuration: Duration(milliseconds:500),
            closedBuilder: (BuildContext context,VoidCallback openContainer){
              return Container(
                child:Image.asset(
                  'assets/images/longmao.jpg',
                  fit: BoxFit.fitWidth,
                )
              );
            }, 
            openBuilder: (BuildContext context,VoidCallback _){
              return DetailPage();
            }
          );
        }
      ),
    );
  }
}