import 'package:flutter/material.dart';
import 'map_country_to_iso.dart';

class CountryInfo {
  final String name;
  final String isoCode;
  final String numberOfCases;
  final String numberOfDeaths;
  final String totalRecovered;
  final String activeCases;
  final String recordDateString;

  CountryInfo(
      {@required this.name,
      this.isoCode = '',
      this.numberOfCases = '0',
      this.numberOfDeaths = '0',
      this.activeCases = '0',
      this.totalRecovered = '0',
      this.recordDateString = '2019-12-20 00:00:00.000'});

  DateTime get recordDate =>
      DateTime.tryParse(recordDateString) ?? DateTime.now();
  int get cases => int.tryParse(numberOfCases.replaceAll(',', ''));

  @override
  String toString() =>
      '{ name: $name isoCode: $isoCode numberOfCases: $numberOfCases numberOfDeaths: $numberOfDeaths totalRecovered: $totalRecovered activeCases: $activeCases recordDate: $recordDateString }';

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
        name: json['country_name'] as String,
        isoCode: mapCountryToIso[json['country_name']] ?? 'XX',
        numberOfCases: json['cases'] as String,
        numberOfDeaths: json['deaths'] as String,
        totalRecovered: json['total_recovered'] as String,
        activeCases: json['active_cases'] as String,
        recordDateString: json['record_date'] as String ?? '');
  }
}
