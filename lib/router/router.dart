import 'package:appdemo/pages/home/home_page.dart';
import 'package:appdemo/pages/user/user_detail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    CustomRoute(page: HomePage,initial: true),
    CustomRoute(page: UserDetail, transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
)
class $Router {}