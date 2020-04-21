import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/core/models/world_info.dart';
import 'package:covid19_info/core/repositories/covid19_info_repository.dart';
import 'package:covid19_info/core/services/location_service.dart';
import 'package:covid19_info/core/viewmodels/base_view_model.dart';
import 'package:covid19_info/locator.dart';

class WorldCasesListViewModel extends BaseModel {
  final repository = Covid19InfoRepository();

  //Contains all the data from the API
  List<CountryInfo> _countryInfoList = [];
  //Filtered version of the data retived from the API
  List<CountryInfo> _filteredCountryInfoList = [];

  List<CountryInfo> _top5ByCasesCountryInfoList = [];

  WorldInfo _worldInfo = WorldInfo();

  WorldInfo get worldInfo => _worldInfo;

  CountryInfo userLocation;
  String _userCountryName = '';

  //If there is a filter term return the filtered list else return the full list
  List<CountryInfo> get countryInfoList =>
      _filterText == '' ? _countryInfoList : _filteredCountryInfoList;

  List<CountryInfo> get top5ByCasesCountryInfoList {
    _top5ByCasesCountryInfoList.clear();
    _top5ByCasesCountryInfoList.addAll(_countryInfoList);
    _top5ByCasesCountryInfoList.sort((b, a) =>
        int.parse(a.numberOfCases.replaceAll(',', ''))
            .compareTo(int.parse(b.numberOfCases.replaceAll(',', ''))));
    final endIndex = _top5ByCasesCountryInfoList.length >= 5
        ? 5
        : _top5ByCasesCountryInfoList.length;
    _top5ByCasesCountryInfoList =
        _top5ByCasesCountryInfoList.getRange(0, endIndex).toList();
    return _top5ByCasesCountryInfoList;
  }

  bool hasUserLocation() {
    return userLocation != null && _userCountryName != '';
  }

  String _filterText = '';

  set filterText(String text) {
    setState(ViewState.Busy);
    _filterText = text;

    if (_filterText == '') {
      setState(ViewState.Idle);
      return;
    }

    _filteredCountryInfoList = _countryInfoList
        .where((countryInfo) => countryInfo.name
            .toLowerCase()
            .startsWith(_filterText.toLowerCase()))
        .toList();
    setState(ViewState.Idle);
  }

  Future loadData() async {
    setState(ViewState.Busy);

    await _getCovid19InfoCountryList();
    await _getWorldTotalStat();
    await _getUserLocation();

    setState(ViewState.Idle);
  }

  Future _getCovid19InfoCountryList() async {
    _countryInfoList.clear();

    try {
      Map<String, dynamic> jsonData = await repository.getCasesByCountry();

      List<dynamic> countryListData = jsonData['countries_stat'];
      countryListData.forEach((jsonCountry) =>
          _countryInfoList.add(CountryInfo.fromJson(jsonCountry)));

      //Remove countries where the name field is empty
      _countryInfoList.removeWhere((country) => country.name == '');

      //Sort Country List by name
      _countryInfoList.sort((a, b) => a.name.compareTo(b.name));

      //_countryInfoList.forEach((country) => print(country));
    } catch (e) {
      setState(ViewState.Error);
      throw e;
    }
  }

  Future _getWorldTotalStat() async {
    try {
      Map<String, dynamic> jsonData = await repository.getWorldTotalStat();
      _worldInfo = WorldInfo.fromJson(jsonData);
      print('getWorldTotalStat: $_worldInfo');
    } catch (e) {
      setState(ViewState.Error);
      throw e;
    }
  }

  Future<void> _getUserLocation() async {
    final locationService = locator<LocationService>();
    if (await locationService.hasPermission()) {
      try {
        print('Location Perssmision Granted!');
        _userCountryName = await locationService.getPlaceForCurrentLocation();
        userLocation = _countryInfoList.firstWhere(
            (info) => info.name.toLowerCase() == _userCountryName,
            orElse: () => null);
      } catch (e) {
        userLocation = null;
        _userCountryName = '';
        print(e);
      }
    } else {
      userLocation = null;
      _userCountryName = '';
      print('Location Perssmision Denied!');
    }
  }
}
