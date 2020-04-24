import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/chart_data.dart';
import 'package:covid19_info/core/repositories/covid19_info_repository.dart';
import 'package:covid19_info/locator.dart';
import 'base_view_model.dart';

class CountryDetailViewModel extends BaseModel {
  final _repository = locator<Covid19InfoRepository>();

  List<ChartData> dataList = [];

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

      dataList = countryListData
          .map((countryData) => ChartData.fromJson(countryData))
          .toList();

      final Map<DateTime, ChartData> dataMap = {};
      dataList.forEach((data) => dataMap[data.date] = data);

      print('_dataList.lenght: ${dataList.length}');

      dataList.clear();

      print('_dataList.lenght: ${dataList.length}');

      dataMap.forEach((key, value) => dataList.add(value));

      print('dataList.lenght: ${dataList.length}');
    } catch (e) {
      setState(ViewState.Error);
      throw e;
    }
  }
}
