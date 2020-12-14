

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class DetailOfHouse extends StatelessWidget {
  final Advertisment room;
  final List<Imagery> image;

  DetailOfHouse(this.room, this.image);
  var _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 330,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 330,
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      if (image[index].advertismentId == room.id) {
                        return new Image.network(
                          Strings.imageurl + image[index].thumbnailimages,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return new Image.asset(
                          image[0].images,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                    itemCount: image.length,
                    pagination: new SwiperPagination(),
        
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 50,
                    height: 50,
             

                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        // color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  top: 32,
                  left: 15,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                //column for whole container
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10, top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: media.size.width - 64 - 48,
                                child: Text(
                                  room.name,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(room.description,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                  overflow: TextOverflow.visible),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                '\$' + room.price + " /Monthly",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigation),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.contract,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.local_offer,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.rooms.toString() + " Bed Rooms",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.airline_seat_legroom_reduced,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.bathRooms.toString() + " Bathrooms",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_pin,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.street,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.mail_outline_outlined,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Apt# " + room.apartmentNumber,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_city,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.parish,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.call,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.phoneNumber,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10, top: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email_rounded,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              room.email,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: ClipRRect(
                            child: Image.network(
                              Strings.imageurl + room.user.profilePhoto,
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                room.user.firstName + " " + room.user.lastName,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Owner",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            "Chat",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Contact Us',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),),
                                    content: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Positioned(
                                          right: -30.0,
                                          top: -90.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: nameController,
                                                  cursorColor: Colors.white,
                                                  decoration: InputDecoration(
                                                    icon:
                                                        Icon(Icons.account_box),
                                                    hintText: "Name",
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white70)),
                                                    hintStyle: TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  controller: emailController,
                                                  cursorColor: Colors.white,
                                                  decoration: InputDecoration(
                                                    icon: Icon(Icons.email),
                                                    hintText: "Email",
                                                    border: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white70)),
                                                    hintStyle: TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 80.0,
                                                  child: TextFormField(
                                                    controller:
                                                        messageController,
                                                    cursorColor: Colors.white,
                                                    decoration: InputDecoration(
                                                      icon: Icon(Icons.message),
                                                      hintText: "Message",
                                                      border: UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .white70)),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                      // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: RaisedButton(
                                                  child: Text("Send"),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      sendmessage(
                                                          nameController.text,
                                                          emailController.text,
                                                          messageController.text,
                                                          room.user.id.toString(),
                                                          context);
                                                        //   if (sent) {
                                                        // onSent(context);
                                                        // } else {
                                                        //  notsent(context);
                                                        // }
                                                      _formKey.currentState
                                                          .save();
                                                    }
                                                  },
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Amenities",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    room.amenity,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  onSent(context) {
     showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image.asset('assets/message_sent.gif'),
              title: Text('Message Sent!',
                textAlign: TextAlign.center,
                style:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                "Your message was sent, and will be responded to in short order",
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              onlyOkButton: true,
              buttonOkText: Text('Close'),
              onOkButtonPressed: () {
                
              },
            ));
  }
  
  notsent(context) {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: Image.asset('assets/notsent.gif'),
              title: Text('Oh No!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                "Your message wasn't sent, please check your connections",
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.BOTTOM_RIGHT,
              onlyOkButton: true,
              buttonOkText: Text('Close'),
              onOkButtonPressed: () {
                
              },
            ));
  }

  sendmessage(String name, email, message, user,context) async {
    Map data = {'name': email, 'email': email, 'message': message};
    var response = await http.post(Strings.send + user, body: data);
    print(Strings.send + user);
    if (response.statusCode == 200) {
          onSent(context);
    } else {
         notsent(context);
    }
  }
}
