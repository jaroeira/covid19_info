import 'package:covid19_info/locator.dart';
import 'package:covid19_info/ui/const.dart';
import 'package:covid19_info/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  //     .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Info App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: HomeScreen.id,
    );
  }
}
