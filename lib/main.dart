import 'package:appdemo/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'common/theme.dart';
import 'config/injector.dart';

import 'local/storage/storage_manager.dart';

void main() async{
  Injector.register();
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(App());
}



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
     child: MaterialApp(
        title: 'Flutter',
        theme: AppTheme.lightTheme,
          builder: ExtendedNavigator<Router>(
          //initialRoute: Routes.indexPageRoute,
          router: Router(),
          //guards: [AuthGuard()],
        ),
      ),
    );
  }
}