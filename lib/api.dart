import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Api {
  final HttpClient _httpClient = HttpClient();

  final String _url = 'api.vajehyab.com';
  final String _token = '67700.rfSG8YMPocCpC3r0OaxiEL7qnDJHJVubbnRjlE9K';
  final String _product = 'f_vazhe';

  Future<Map<String, dynamic>> getSuggest(String q) async {
    final uri = Uri.http(
        _url, '/v3/suggest', {'token': _token, 'product': _product, 'q': q});
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['data'] == null) {
      print('Error retrieving units.');
      return null;
    }
    return jsonResponse['data']['suggestion'];
  }

  Future<List<dynamic>> getSearch(String q, String type) async {
    final uri = Uri.http(_url, '/v3/search',
        {'token': _token, 'product': _product, 'q': q, 'type': type});
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['data'] == null) {
      print('Error retrieving.');
      return null;
    }
    return jsonResponse['data']['results'];
  }

  Future<dynamic> getWord(String title, String db, int num) async {
    final uri = Uri.http(_url, '/v3/word', {
      'token': _token,
      'product': _product,
      'title': title,
      'db': db,
      'num': num.toString()
    });
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['word'] == null) {
      print('Error retrieving.');
      return null;
    }
    return jsonResponse['word'];
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return jsonDecode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
