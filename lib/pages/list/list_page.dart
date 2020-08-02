import 'package:appdemo/bloc/post_bloc.dart';
import 'package:appdemo/pages/list/child_page_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'child_page.dart';
import 'child_page_two.dart';

class ListPage extends StatefulWidget{
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
          PostBloc()..add(PostFetched()),
        child:LoadMoreDemo()
      ),
    );
  }
}