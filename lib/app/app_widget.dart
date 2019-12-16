import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black45,
        systemNavigationBarColor: Color(0xff664EB8),
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primaryColor: Color(0xff664EB8),
        // primaryTextTheme: TextTheme(
        //   button: TextStyle(
        //     color: Colors.white
        //   )
        // )
      ),
      initialRoute: "/",
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
