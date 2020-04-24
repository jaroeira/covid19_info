import 'package:flutter/material.dart';

class ChartData {
  final String countryName;
  final DateTime recordDate;
  final int cases;

  ChartData(
      {this.countryName, @required this.cases, @required this.recordDate});

  DateTime get date =>
      DateTime(recordDate.year, recordDate.month, recordDate.day);

  @override
  String toString() =>
      '{ countryName: $countryName recordDate $recordDate cases $cases }';

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      countryName: json['country_name'],
      cases: int.tryParse(json['total_cases'].replaceAll(',', '')),
      recordDate:
          DateTime.tryParse(json['record_date']) ?? DateTime(2019, 12, 20),
    );
  }
}
