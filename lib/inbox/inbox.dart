import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/inbox/view_inbox.dart';
import 'package:homebound/models/userdata.dart';
import 'package:line_icons/line_icons.dart';


class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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


  String path;
  TextEditingController _searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    userData != null
        ? path = '${userData['profile_photo']}'
        : path = '/uploads/images/android-user-icon-4.png';
    return SafeArea(
        child: ListView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(Strings.imageurl + path),
                      fit: BoxFit.cover)),
            ),
            Text(
              "Chats",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.edit)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: TextField(
            cursorColor: black,
            controller: _searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  LineIcons.search,
                  // color: black.withOpacity(0.5),
                ),
                hintText: "Search",
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        userData != null
            ? Column(
                children: List.generate(userData['unread_notifications'].length,
                    (index) {
                  var data =
                      userData != null ? userData['unread_notifications'] : '';
                  return Card(
                    child: ListTile(
                        title: Text(
                          data != null ? data[index]['data']['name'] : '',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            data != null ? data[index]['data']['body'] : '',
                            style: TextStyle(color: Colors.grey)),
                        trailing: Text('j'),
                        dense: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatDetailPage()));
                        }),
                  );
                }),
              )
            : Column(
                children: List.generate(1, (index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'No Notifications',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      dense: true,
                    ),
                  );
                }),
              )
      ],
    ));
  }
}
