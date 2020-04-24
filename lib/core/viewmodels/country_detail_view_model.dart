import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/core/repositories/covid19_info_repository.dart';
import 'package:covid19_info/locator.dart';
import 'base_view_model.dart';

class CountryDetailViewModel extends BaseModel {
  final _repository = locator<Covid19InfoRepository>();

  List<CountryInfo> _countryHistoryList = [];
  List<DateTime> recordDates = [];

  List<CountryInfo> get countryHistoryList => _countryHistoryList;

  Future<void> loadData({String countryName}) async {
    if (countryName == null || countryName == '') return;
    setState(ViewState.Busy);
    await _getCountryCovid19History(countryName);
    setState(ViewState.Idle);
  }

  Future<void> _getCountryCovid19History(String countryName) async {
    try {
      Map<String, dynamic> jsonData =
          await _repository.getHistoryByParticularCountry(countryName);

      if (jsonData.length == 0) {
        setState(ViewState.Error);
        return;
      }

      List<dynamic> countryListData = jsonData['stat_by_country'];

      _countryHistoryList = countryListData
          .map((countryData) => CountryInfo.fromJson(countryData))
          .toList();
      _parseRecordData();
    } catch (e) {
      setState(ViewState.Error);
      throw e;
    }
  }

  void _parseRecordData() {
    recordDates = _countryHistoryList
        .map((info) => DateTime.tryParse(info.recordDateString))
        .toList();

    recordDates.sort((a, b) => b.compareTo(a));
  }
}
