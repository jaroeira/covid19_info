import 'package:flutter/material.dart';

const chiCountryNameJsonKey = 'country_name';
const chiRecordDatesJsonKey = 'record_date';
const chiCasesJsonKey = 'total_cases';
const chiTotalDeathsJsonKey = 'total_deaths';
const chiTotalRecoveredJsonKey = 'total_recovered';
const chiNewCasesJsonKey = 'new_cases';

class ChartData {
  final String countryName;
  final DateTime recordDate;
  final int cases;
  final int totalDeaths;
  final int totalRecovered;
  final int newCases;

  ChartData(
      {this.countryName,
      @required this.cases,
      @required this.recordDate,
      @required this.totalDeaths,
      @required this.totalRecovered,
      @required this.newCases});

  DateTime get date =>
      DateTime(recordDate.year, recordDate.month, recordDate.day);

  @override
  String toString() =>
      '{ countryName: $countryName recordDate $recordDate cases $cases }';

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      countryName: json[chiCountryNameJsonKey],
      cases: int.tryParse(json[chiCasesJsonKey].replaceAll(',', '')) ?? 0,
      recordDate: DateTime.tryParse(json[chiRecordDatesJsonKey]) ??
          DateTime(2019, 12, 20),
      totalDeaths:
          int.tryParse(json[chiTotalDeathsJsonKey].replaceAll(',', '')) ?? 0,
      totalRecovered:
          int.tryParse(json[chiTotalRecoveredJsonKey].replaceAll(',', '')) ?? 0,
      newCases: int.tryParse(json[chiNewCasesJsonKey].replaceAll(',', '')) ?? 0,
    );
  }
}
