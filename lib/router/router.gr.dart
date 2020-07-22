// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/user/user_detail.dart';

class Routes {
  static const String userDetail = '/user-detail';
  static const all = <String>{
    userDetail,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.userDetail, page: UserDetail),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    UserDetail: (data) {
      var args = data.getArgs<UserDetailArguments>(
        orElse: () => UserDetailArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserDetail(uuid: args.uuid),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// UserDetail arguments holder class
class UserDetailArguments {
  final String uuid;
  UserDetailArguments({this.uuid});
}
