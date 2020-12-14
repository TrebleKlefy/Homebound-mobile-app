import 'package:homebound/constants/strings.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:homebound/models/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class APIManager {
  Future<AvertisementModel> getListing(string) async {
    var avertisementModel;
    var response;

    try {
      if (string == 'empty_string') {
        response = await http.get('http://10.0.2.2:8000/api/apilistings');
      } else {
        Map data = {
          'search': string,
        };
        response = await http.post(Strings.filterurl, body: data);
      }
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(response.body);
        var jsonMap = json.decode(jsonString);
        avertisementModel = AvertisementModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      print(Exception);
      // return avertisementModel;
    }
    return avertisementModel;
  }

  getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    return user;
  }

  Future<NotificationModel> getNotifiaction(user) async {
    var client = http.Client();
    var avertisementModel;
    var response;
    try {
      response = await client.get(Strings.notifications + user);
      if (response.statusCode == 200) {
        var jsonString = response.body.toString();
        var jsonMap = json.decode(jsonString);
        avertisementModel = NotificationModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return avertisementModel;
    }
    return avertisementModel;
  }

  getcount(user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var client = http.Client();
    var response;
    try {
      response = await client.get(Strings.count + user);
      if (response.statusCode == 200) {
        var jsonString = response.body.toString();
        var jsonMap = json.decode(jsonString);
        sharedPreferences.setString("review", jsonMap['review']);
        sharedPreferences.setString("addcount", jsonMap['addscount']);
      }
    } catch (Exception) {}
  }
}
