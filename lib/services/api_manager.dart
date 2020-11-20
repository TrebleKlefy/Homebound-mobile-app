import 'package:homebound/constants/strings.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';



class APIManager {
  Future<AvertisementModel> getListing(string) async {
    var client = http.Client();
    var avertisementModel;
    var response;
    try {
      if (string == 'empty_string') {
        response = await client.get('http://10.0.2.2:8000/api/apilistings');
        print(response);
      } else {
        response = await http.post(Strings.filterurl, body: string);
      }
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        avertisementModel = AvertisementModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      print(Exception);
      return avertisementModel;
    }
    return avertisementModel;
  }

 getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    return  user;
  }
}
