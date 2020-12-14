import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/notification.dart';
import 'package:http/http.dart' as http;

class ChatDetailPage extends StatelessWidget {
  final Notifications note;
  final int id;
  ChatDetailPage({this.note, this.id});

  @override
  Widget build(BuildContext context) {
    readMessage(note.id, id);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: grey.withOpacity(0.2),
          elevation: 0,
          leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                // color: primary,
              )),
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    note.data.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 50, bottom: 80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  decoration: BoxDecoration(color: grey),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Text(
                          note.data.name,
                          style: TextStyle(
                              color: black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          note.data.body,
                          style: TextStyle(color: black, fontSize: 17),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          note.data.thanks,
                          style: TextStyle(
                              color: black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  readMessage(nid, uid) async {
    return await http.get(Strings.read + nid.toString() + '/' + uid.toString());
  }
}
