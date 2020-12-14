import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/models/userdata.dart';
import 'package:homebound/navigation_bar/primary_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfile(),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userData;
  var count;

  @override
  void initState() {
    Userdata().getUserInfo().then((user) {
      setState(() {
        userData = user;
      });
    });
    Userdata().getAddCount().then((count) {
      setState(() {
        count = count;
      });
    });
    super.initState();
  }

  final String _followers = "1";
  var _posts = "24";
  var _scores = "450";
  String path;

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [1.0, 0.5],
          colors: [
            Color.fromRGBO(23, 43, 77, 1.0),
            Color.fromRGBO(26, 23, 77, 1.7),
          ],
        ),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Color.fromRGBO(26, 23, 77, 0.1), BlendMode.dstATop),
          image: AssetImage('assets/travelthree.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    userData != null
        ? path = '${userData['profile_photo']}'
        : path = '/uploads/images/clipart.png';
    print(path);
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, bottom: 10),
        child: Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(Strings.imageurl + path),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      userData != null
          ? '${userData['first_name']}' + '${userData['last_name']}'
          : '',
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '',
        style: TextStyle(
          fontFamily: 'Spectral',
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    userData != null
        ? userData['unread_notifications'] != null
            ? _posts = userData['unread_notifications'].length.toString()
            : _posts = '0'
        : _posts = '0';

    count != null
        ? count != null
            ? _scores = count.length.toString()
            : _scores = '0'
        : _scores = '0';
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(
          // color: Color(0xFFEFF4F7),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Advertisements", _followers),
          _buildStatItem("Notifications", _posts),
          _buildStatItem("Reviews", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        userData != null
            ? '${userData['aboutuser']}'
            : 'No data as yet,please add',
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        child: Text(
          "Thanks for making it HomeBound,",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                logout();
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => PrimayNav()));
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
