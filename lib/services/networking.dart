import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.URL});
  final URL;

  Future netWorkData() async {
    http.Response response = await http.get(URL);
    var responseBodyData = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(responseBodyData);
    } else {
      print(response.statusCode);
    }
  }
}
