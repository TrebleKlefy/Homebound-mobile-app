import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Userdata{
    getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    
     return  user;
     
  }
  getAddCount() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var countJson = localStorage.getString('advert');
    var advertcount = json.decode(countJson.toString());
    
     return  advertcount;
     
  }
}