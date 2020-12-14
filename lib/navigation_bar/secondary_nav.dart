import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:homebound/helpers/sizeConfig.dart';
import 'package:homebound/inbox/inbox.dart';
import 'package:homebound/models/userdata.dart';
import 'package:homebound/views/homepage.dart';
import 'package:homebound/views/profile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:badges/badges.dart';

class SecondaryNav extends StatefulWidget {
  SecondaryNav({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondaryNavState createState() => _SecondaryNavState();
}

class _SecondaryNavState extends State<SecondaryNav>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  int badge = 0;
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  var userData;
  var user;
  @override
  void initState() {
    Userdata().getUserInfo().then((user) {
      setState(() {
        userData = user;
        user = userData['id'];
      });
    });
    super.initState();
  }

  List<Widget> _widgetOptions = <Widget>[
    UserProfile(),
    Inbox(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 10 * SizeConfig.heightMultiplier,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
                gap: 6,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.blue,
                tabs: [
                  GButton(
                    gap: gap,
                    backgroundColor: Colors.blue.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                  GButton(
                    gap: gap,
                    backgroundColor: Colors.blue.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: LineIcons.bell,
                    leading: badge == 0
                        ? null
                        : Badge(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                            position: BadgePosition.topEnd(top: -12),
                            badgeContent: Text(
                              badge.toString(),
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            child: Icon(
                              LineIcons.bell,
                              color:
                                  _selectedIndex == 1 ? Colors.red : Colors.red,
                            )),
                    text: 'Notifications',
                  ),
                  GButton(
                    gap: gap,
                    backgroundColor: Colors.blue.withOpacity(.2),
                    iconSize: 24,
                    padding: padding,
                    icon: LineIcons.home,
                    text: 'Home',
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
