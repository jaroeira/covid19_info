import 'package:flutter/material.dart';

class WorldInfo {
  final String totalCases;
  final String newCases;
  final String totalDeaths;
  final String newDeaths;
  final String totalRecovered;
  final String activeCases;
  final String seriousCritical;
  final DateTime statisticTakenAt;

  String get statisticDateAsString {
    final String strDate =
        '${statisticTakenAt.day}.${statisticTakenAt.month}.${statisticTakenAt.year}';
    return strDate;
  }

  WorldInfo(
      {this.totalCases = '0',
      this.newCases = '0',
      this.totalDeaths = '0',
      this.newDeaths = '0',
      this.totalRecovered = '0',
      this.activeCases = '0',
      this.seriousCritical = '0',
      this.statisticTakenAt});

  @override
  String toString() =>
      '{ totalCases: $totalCases, newCases: $newCases, totalDeaths: $totalDeaths, totalRecovered: $totalRecovered, statisticTakenAt: $statisticTakenAt }';

  factory WorldInfo.fromJson(Map<String, dynamic> json) {
    return WorldInfo(
      totalCases: json['total_cases'] as String,
      newCases: json['new_cases'] as String,
      totalDeaths: json['total_deaths'] as String,
      newDeaths: json['new_deaths'] as String,
      totalRecovered: json['total_recovered'] as String,
      activeCases: json['active_cases'] as String,
      seriousCritical: json['serious_critical'] as String,
      statisticTakenAt: DateTime.tryParse(json['statistic_taken_at']),
    );
  }
}
