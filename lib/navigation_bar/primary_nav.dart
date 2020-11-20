import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:homebound/helpers/sizeConfig.dart';
import 'package:homebound/login/login.dart';
import 'package:homebound/navigation_bar/loggedIn.dart';
import 'package:homebound/views/homepage.dart';
import 'package:homebound/views/profileTwo.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimayNav extends StatefulWidget {
  PrimayNav({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _PrimayNavState createState() => _PrimayNavState();
}

class _PrimayNavState extends State<PrimayNav> with SingleTickerProviderStateMixin{

SharedPreferences sharedPreferences;
int _selectedIndex = 0;

  int badge = 0;
   var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  List<Widget> _widgetOptions = <Widget>[
  Home(),
  ProfileSecond(),
  LogIn(),

  ];


  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoggedIn()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 10 * SizeConfig.heightMultiplier,
        decoration: BoxDecoration( boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
                gap: 6,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.blue,
                tabs: [
                  GButton(
                     gap:gap,
                      backgroundColor: Colors.blue.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                      gap:gap,
                      backgroundColor: Colors.blue.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                    icon: LineIcons.calendar,
                    text: 'Trips',
                  ),
                  GButton(
                     gap:gap,
                      backgroundColor: Colors.blue.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.sign_in,
                    text: 'Login',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}