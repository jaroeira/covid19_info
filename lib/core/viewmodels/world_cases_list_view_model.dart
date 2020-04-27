import 'package:covid19_info/core/enums/view_state.dart';
import 'package:covid19_info/core/models/country_info.dart';
import 'package:covid19_info/core/models/world_info.dart';
import 'package:covid19_info/core/repositories/covid19_info_repository.dart';
import 'package:covid19_info/core/services/location_service.dart';
import 'package:covid19_info/core/viewmodels/base_view_model.dart';
import 'package:covid19_info/locator.dart';

enum CountryInfoListSortType {
  Cases,
  Deaths,
  Active,
  Recovered,
  Name,
}

class WorldCasesListViewModel extends BaseModel {
  final repository = locator<Covid19InfoRepository>();

  //Contains all the data from the API
  List<CountryInfo> _countryInfoList = [];
  //Filtered version of the data retived from the API
  List<CountryInfo> _filteredCountryInfoList = [];
  //Sorted version of the data retived from the API
  List<CountryInfo> _sortedCountryInfoList = [];

  //List with Top 5 counstries with most cases
  List<CountryInfo> _top5ByCasesCountryInfoList = [];

  //World Statistic numbers
  WorldInfo _worldInfo = WorldInfo();

  WorldInfo get worldInfo => _worldInfo;

  CountryInfo userLocation;
  String _userIsoCountryCode = '';

  //If there is a filter term return the filtered list else return the full list
  List<CountryInfo> get countryInfoList =>
      _filterText == '' ? _sortedCountryInfoList : _filteredCountryInfoList;

  //Return a list with the Top 5 contries with the most cases
  List<CountryInfo> get top5ByCasesCountryInfoList {
    _top5ByCasesCountryInfoList.clear();
    _top5ByCasesCountryInfoList.addAll(_countryInfoList);
    _top5ByCasesCountryInfoList
        .sort((b, a) => a.casesAsInt.compareTo(b.casesAsInt));
    final endIndex = _top5ByCasesCountryInfoList.length >= 5
        ? 5
        : _top5ByCasesCountryInfoList.length;
    _top5ByCasesCountryInfoList =
        _top5ByCasesCountryInfoList.getRange(0, endIndex).toList();
    return _top5ByCasesCountryInfoList;
  }

  //Check if the app has the user location
  bool hasUserLocation() {
    return userLocation != null && _userIsoCountryCode != '';
  }

  String _filterText = '';

  //Every time a search term is inserted a filtered list is created and the UI receives a notification to refresh
  set filterText(String text) {
    setState(ViewState.Busy);
    _filterText = text;

    if (_filterText == '') {
      setState(ViewState.Idle);
      return;
    }

    _filteredCountryInfoList = _sortedCountryInfoList
        .where((countryInfo) => countryInfo.name
            .toLowerCase()
            .startsWith(_filterText.toLowerCase()))
        .toList();
    setState(ViewState.Idle);
  }

  //Load all the data from the API
  Future loadData() async {
    setState(ViewState.Busy);

    await _getCovid19InfoCountryList();
    await _getWorldTotalStat();
    await _getUserLocation();

    setState(ViewState.Idle);
  }

  Future _getCovid19InfoCountryList() async {
    _countryInfoList.clear();
    _sortedCountryInfoList.clear();

    try {
      Map<String, dynamic> jsonData = await repository.getCasesByCountry();

      if (jsonData.length == 0) {
        setState(ViewState.Error);
        return;
      }

      List<dynamic> countryListData = jsonData['countries_stat'];
      countryListData.forEach((jsonCountry) =>
          _countryInfoList.add(CountryInfo.fromJson(jsonCountry)));

      //Remove countries where the name field is empty
      _countryInfoList.removeWhere((country) => country.name == '');

      //Sort Country List by name
      _countryInfoList.sort((a, b) => a.name.compareTo(b.name));
      _sortedCountryInfoList.addAll(_countryInfoList);
    } catch (e) {
      setState(ViewState.Error);
      throw e;
    }
  }

  Future _getWorldTotalStat() async {
    try {
      Map<String, dynamic> jsonData = await repository.getWorldTotalStat();
      _worldInfo = WorldInfo.fromJson(jsonData);
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
        _userIsoCountryCode =
            await locationService.getPlaceForCurrentLocation();
        userLocation = _countryInfoList.firstWhere(
            (info) => info.isoCode.toLowerCase() == _userIsoCountryCode,
            orElse: () => null);
      } catch (e) {
        userLocation = null;
        _userIsoCountryCode = '';
        print(e);
      }
    } else {
      userLocation = null;
      _userIsoCountryCode = '';
      print('Location Perssmision Denied!');
    }
  }

  void toggleSortOder() {
    //_sortedAscending = !_sorted
    setState(ViewState.Busy);
    final reversedList = _sortedCountryInfoList.reversed.toList();
    _sortedCountryInfoList.clear();
    _sortedCountryInfoList.addAll(reversedList);
    setState(ViewState.Idle);
  }

  void sortCountryList(CountryInfoListSortType sortBy) {
    setState(ViewState.Busy);
    switch (sortBy) {
      case CountryInfoListSortType.Cases:
        _sortedCountryInfoList
            .sort((a, b) => a.casesAsInt.compareTo(b.casesAsInt));
        break;
      case CountryInfoListSortType.Deaths:
        _sortedCountryInfoList
            .sort((a, b) => a.deathsAsInt.compareTo(b.deathsAsInt));
        break;
      case CountryInfoListSortType.Active:
        _sortedCountryInfoList
            .sort((a, b) => a.activeCasesAsInt.compareTo(b.activeCasesAsInt));
        break;
      case CountryInfoListSortType.Recovered:
        _sortedCountryInfoList.sort(
            (a, b) => a.totalRecoveredAsInt.compareTo(b.totalRecoveredAsInt));
        break;
      case CountryInfoListSortType.Name:
        _sortedCountryInfoList.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
        _sortedCountryInfoList.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
    setState(ViewState.Idle);
  }
}
