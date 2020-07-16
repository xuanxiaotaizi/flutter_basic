import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/longmao.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}