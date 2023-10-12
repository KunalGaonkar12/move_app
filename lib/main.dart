import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'feature/app/providers.dart';
import 'feature/app/router_constants.dart';
import 'feature/app/router.dart' as router;


void main() {
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,
      ])
      .then((_) {
    runApp( const App());
  });

  // runApp(const App());

}


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.getAProviders(),
      child: const MaterialApp(debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: RouterConstants.MainRoute,
      ));
  }
}



