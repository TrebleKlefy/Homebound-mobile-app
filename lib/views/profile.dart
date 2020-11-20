import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/models/userdata.dart';
import 'package:homebound/navigation_bar/primary_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileFirst(),
    );
  }
}

class ProfileFirst extends StatefulWidget {
  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  // SharedPreferences user =  getSharedPreferences();

   var userData;

  @override
  void initState() {
    Userdata().getUserInfo().then((user) {
      setState(() {
        userData = user;
      });
    });
    super.initState();
  }

  // final String _fullName = "Nick Frost";
  final String _status = "Software Developer";
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  var _posts = "24";
  final String _scores = "450";
  String path;

  Widget _buildCoverImage(Size screenSize) {
    // print(Strings.imageurl + userData['profile_photo']);
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [1.0, 0.5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color.fromRGBO(23, 43, 77, 1.0),
           Color.fromRGBO(26, 23, 77, 1.7),
            // Colors.indigo[600],
            // Colors.indigo[400],
          ],
        ),
        image: DecorationImage(
          
           colorFilter: 
      ColorFilter.mode(Color.fromRGBO(26, 23, 77, 0.1), 
      BlendMode.dstATop),
      
          image: AssetImage('assets/owner1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    userData != null ? path = '${userData['profile_photo']}' : path ='/uploads/images/android-user-icon-4.png';
    print(path);
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 70.0),
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
      // color: Colors.black,
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
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          // color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      // color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      // color: Colors.black54,
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
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      // color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
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
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        child: Text(
          "Need to contact us? Send a message,",
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
          Expanded(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => NetworkGiffyDialog(
                          image: Image.network(
                              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif"),
                          title: Text('Granny Eating Chocolate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600)),
                          description: Text(
                            'This is a granny eating chocolate dialog box. This library helps you easily create fancy giffy dialog',
                            textAlign: TextAlign.center,
                          ),
                          entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                          onOkButtonPressed: () {},
                        ));
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600],
                  ),
                  // color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
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

  
  
}
