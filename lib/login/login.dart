import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/navigation_bar/secondary_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isLoading = false;
  String message = '';
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(40, 52, 74, 0),
            Color.fromRGBO(40, 52, 74, 0)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  registerSection(),
                  errorMessage(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse;

    var response =
        await http.post("http://10.0.2.2:8000/api/login", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString('user', json.encode(jsonResponse['user']));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => SecondaryNav()),
            (Route<dynamic> route) => false);
      }
    } else {
      jsonResponse = json.decode(response.body);
      setState(() {
        _isLoading = false;
        message = jsonResponse['message'];
      });

      print(response.body);
    }
  }

  _launchURL() async {
    var url = Strings.register;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.grey[700],
        child: Text(
          "Sign In",
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/LogoMaker.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Container registerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 55.0, vertical: 0),
      child: InkWell(
        onTap: () {
          _launchURL();
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Text(
            'Sign Up?',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Container errorMessage() {
    return Container(
      padding: const EdgeInsets.all(15.1),
      child: Text(message),
    );
  }
}
