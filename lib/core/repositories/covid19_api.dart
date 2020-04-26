import 'package:http/http.dart' as http;
import 'dart:convert';

class Covid19Api {
  static const String _baseUrl = 'https://covid-193.p.rapidapi.com';

  static const Map<String, String> headers = {
    'x-rapidapi-host': 'covid-193.p.rapidapi.com',
    'x-rapidapi-key': '9118a83df6mshb9cc3dc89ce1fedp16e57ejsn4a59127f4d20'
  };

  static const String _api_get_cases_by_country_endpoint = 'statistics';

  static const String _api_get_world_total_stat_endpoint =
      'history?country=all';

  static const String _api_history_by_particular_country = 'history';

  final _httpClient = http.Client();

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

  Future<Map<String, dynamic>> getHistoryByParticularCountry(
      String countryName) async {
    final uri = Uri.https('covid-193.p.rapidapi.com',
        '/$_api_history_by_particular_country', {'country': countryName});

    Map<String, dynamic> jsonData = {};

    try {
      final response = await _httpClient.get(uri, headers: headers);
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return jsonData;
  }
}
