import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Covid19InfoRepository {
  static const String _baseUrl =
      'https://coronavirus-monitor.p.rapidapi.com/coronavirus';
  static const String _api_get_cases_by_country_endpoint =
      'cases_by_country.php';

  static const String _api_get_world_total_stat_endpoint = 'worldstat.php';

  static const String _api_history_by_particular_country =
      'cases_by_particular_country.php';

  static const Map<String, String> headers = {
    'x-rapidapi-host': 'coronavirus-monitor.p.rapidapi.com',
    'x-rapidapi-key': '9118a83df6mshb9cc3dc89ce1fedp16e57ejsn4a59127f4d20'
  };

  var _httpClient = http.Client();

  Future<Map<String, dynamic>> getCasesByCountry() async {
    //Api Url String to the get_cases_by_country endpoint
    String requestUrl = '$_baseUrl/$_api_get_cases_by_country_endpoint';

    Map<String, dynamic> jsonData = {};

    try {
      final response = await _httpClient.get(requestUrl, headers: headers);

      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return jsonData;
  }

  Future<Map<String, dynamic>> getWorldTotalStat() async {
    //Api Url String to the get_world_total_stat endpoint
    String requestUrl = '$_baseUrl/$_api_get_world_total_stat_endpoint';

    Map<String, dynamic> jsonData = {};

    try {
      final response = await _httpClient.get(requestUrl, headers: headers);
      jsonData = json.decode(response.body);
    } catch (err) {
      throw (err);
    }

    return jsonData;
  }

  void dispose() {
    _httpClient.close();
  }

  Future<Map<String, dynamic>> getHistoryByParticularCountry(
      String countryName) async {
    final uri = Uri.https(
        'coronavirus-monitor.p.rapidapi.com',
        '/coronavirus/$_api_history_by_particular_country',
        {'country': countryName});

    Map<String, dynamic> jsonData = {};

    try {
      final response = await _httpClient.get(uri, headers: headers);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        return jsonData;
      }
    } catch (err) {
      print(err);
      throw (err);
    }
  }
}
