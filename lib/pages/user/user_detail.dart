import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget{
  final String uuid;
  UserDetail({this.uuid});
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user_detail'),
      ),
      body: Text('${widget.uuid}'),
    );
  }
}