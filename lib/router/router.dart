import 'package:appdemo/pages/user/user_detail.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: UserDetail),
  ],
)
class $Router {}