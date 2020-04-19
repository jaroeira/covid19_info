import 'package:flutter/material.dart';

class CountryInfo {
  final String name;
  final String numberOfCases;
  final String numberOfDeaths;
  final String totalRecovered;
  final String activeCases;

  CountryInfo(
      {@required this.name,
      this.numberOfCases = '0',
      this.numberOfDeaths = '0',
      this.activeCases = '0',
      this.totalRecovered = '0'});

  @override
  String toString() =>
      '{ name: $name numberOfCases: $numberOfCases numberOfDeaths: $numberOfDeaths totalRecovered: $totalRecovered activeCases: $activeCases }';

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      name: json['country_name'] as String,
      numberOfCases: json['cases'] as String,
      numberOfDeaths: json['deaths'] as String,
      totalRecovered: json['total_recovered'] as String,
      activeCases: json['active_cases'] as String,
    );
  }
}
