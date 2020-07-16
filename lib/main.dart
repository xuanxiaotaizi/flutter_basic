import 'package:appdemo/provider/provider_manager.dart';
import 'package:appdemo/router/application.dart';
import 'package:appdemo/router/router.dart';
import 'package:appdemo/storage/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'common/ui/theme.dart';
import 'config/injector.dart';
import 'package:fluro/fluro.dart';

import 'navigator/tab_navigator.dart';

void main() async{
  Injector.register();
  //await StorageManager.init();
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(App());
}



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers:providers,
        child: MaterialApp(
          title: 'Flutter',
          theme: AppTheme.lightTheme,
          onGenerateRoute:Application.router.generator,
          home:TabNavigator()
        ),
      ),
    );
  }
}