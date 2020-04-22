import 'package:covid19_info/locator.dart';
import 'package:covid19_info/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
      title: 'Covid-19 Info App',
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}
