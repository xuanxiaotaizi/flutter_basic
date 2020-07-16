import 'package:appdemo/pages/login/login_page.dart';
import 'package:appdemo/pages/user/user_detail.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

final Map<String,Handler> routes = {
  "/login":Handler(handlerFunc: (BuildContext context,Map<String, List<String>> params){
    return LoginPage();
  }),
  "/user_detail/:uuid":Handler(handlerFunc: (BuildContext context,Map<String, List<String>> params){
    return UserDetail(
      uuid:params["uuid"].first,
    );
  })
};