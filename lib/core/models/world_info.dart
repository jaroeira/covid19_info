const wiTotalCasesJsonKey = 'total_cases';
const wiNewCasesJsonKey = 'new_cases';
const wiNewDeathsJsonKey = 'new_deaths';
const wiTotalDeathsJsonKey = 'total_deaths';
const wiTotalRecoveredJsonKey = 'total_recovered';
const wiActiveCasesJsonKey = 'active_cases';
const wiSeriousCriticalJsonKey = 'serious_critical';
const wiStatisticTakenAtJsonKey = 'statistic_taken_at';

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
      totalCases: json[wiTotalCasesJsonKey] as String,
      newCases: json[wiNewCasesJsonKey] as String,
      totalDeaths: json[wiTotalDeathsJsonKey] as String,
      newDeaths: json[wiNewDeathsJsonKey] as String,
      totalRecovered: json[wiTotalRecoveredJsonKey] as String,
      activeCases: json[wiActiveCasesJsonKey] as String,
      seriousCritical: json[wiSeriousCriticalJsonKey] as String,
      statisticTakenAt: DateTime.tryParse(json[wiStatisticTakenAtJsonKey]),
    );
  }
}
