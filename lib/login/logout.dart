
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  logingout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse;
   String shared = (sharedPreferences.getString('token') ?? 0);
    var response =
    await http.post("http://192.168.0.13:8000/api/logout", body: shared);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
      }
    }
  }
}
