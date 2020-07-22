import 'package:appdemo/provider/provider_manager.dart';
import 'package:appdemo/router/router.gr.dart';
import 'package:appdemo/storage/storage_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'common/ui/theme.dart';
import 'config/injector.dart';

import 'navigator/tab_navigator.dart';

void main() async{
  Injector.register();
  await StorageManager.init();
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
           builder: ExtendedNavigator<Router>(
            //initialRoute: Routes.indexPageRoute,
            router: Router(),
            //guards: [AuthGuard()],
          ),
          home:SplashScreen.navigate(
            backgroundColor: Colors.red,
            name: 'assets/flare/coding.flr',
            next: (context) => TabNavigator(),
            until: () => Future.delayed(Duration(seconds: 3)),
            startAnimation: 'coding',
          ),
        ),
      ),
    );
  }
}