import 'package:covid19_info/core/models/country_info.dart';
import 'package:flutter/material.dart';
import 'package:covid19_info/ui/screens/country_detail_screen.dart';
import 'package:covid19_info/ui/screens/country_list_screen.dart';
import 'package:covid19_info/ui/screens/world_info_screen.dart';
import 'package:covid19_info/ui/screens/home_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case WorldInfoScreen.id:
        return MaterialPageRoute(builder: (context) => WorldInfoScreen());
      case CountryListScreen.id:
        return MaterialPageRoute(builder: (context) => CountryListScreen());
      case CountryDetailScreen.id:
        var countryInfo = settings.arguments as CountryInfo;
        return MaterialPageRoute(
            builder: (context) => CountryDetailScreen(info: countryInfo));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text(
              'No route defined for ${settings.name}',
            )),
          ),
        );
    }
  }
}
