import 'package:flutter/material.dart';
import 'map_country_to_iso.dart';

const ciNameJsonKey = 'country_name';
const ciNumberOfCasesJsonKey = 'cases';
const ciNumberOfDeathsJsonKey = 'deaths';
const ciTotalRecoveredJsonKey = 'total_recovered';
const ciActiveCasesJsonKey = 'active_cases';
const ciRecordDateStringJsonKey = 'record_date';

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
        name: json[ciNameJsonKey] as String,
        isoCode: mapCountryToIso[json[ciNameJsonKey]] ?? 'XX',
        numberOfCases: json[ciNumberOfCasesJsonKey] as String,
        numberOfDeaths: json[ciNumberOfDeathsJsonKey] as String,
        totalRecovered: json[ciTotalRecoveredJsonKey] as String,
        activeCases: json[ciActiveCasesJsonKey] as String,
        recordDateString: json[ciRecordDateStringJsonKey] as String ?? '');
  }
}
