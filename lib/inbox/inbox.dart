import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/inbox/view_inbox.dart';
import 'package:homebound/models/notification.dart';
import 'package:homebound/models/userdata.dart';
import 'package:homebound/services/api_manager.dart';
import 'package:timeago/timeago.dart' as timeago;


class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  Future<NotificationModel> _notificationModel;
  var userData;

  @override
  void initState() {
    Userdata().getUserInfo().then((user) {
      setState(() {
        userData = user;
        _notificationModel = APIManager().getNotifiaction(userData['id'].toString());
        print(userData['id']);
      });
    });
    super.initState();
  }

  String path;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    userData != null
        ? path = '${userData['profile_photo']}'
        : path = '/uploads/images/clipart.png';
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
          height: 30,
        ),
        Column(
              children: <Widget>[
            FutureBuilder<NotificationModel>(
                future: _notificationModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return  Container(
                      width: double.infinity,
                      height: 580.0,
                      child: ListView.builder(
                      itemCount: snapshot.data.notification.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        var notifi = snapshot.data.notification[index];
                      
                     return Card(
                    child: ListTile(
                        title: Text(
                         notifi.data.name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            notifi.data.greeting,
                            style: TextStyle(color: Colors.grey)),
                        trailing: Text(timeago.format(DateTime.parse(notifi.createdAt.toString()))),
                     
                        dense: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChatDetailPage(note: notifi,id:userData['id'])));
                        }),
                  );
                        },
                      ),
                    );
                  }
                   else {
                    return Text(" ");
                  }
                  
                }),
              ]),
                
            
      ],
    ));
  }
}
