import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailOfHouse extends StatelessWidget {
  final Advertisment room;
  final List<Imagery> image;

  DetailOfHouse(this.room, this.image);

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
                         Strings.imageurl +  image[index].thumbnailimages,
                          width:200,
                          height:200,
                          fit: BoxFit.cover,
                        );
                      }else{
                        return new Image.asset(
                          image[0].images,
                          fit: BoxFit.cover,
                        );
                      }
                    },
                    itemCount: image.length,
                    pagination: new SwiperPagination(),
                    // control: new SwiperControl(),
                  ),
                ),
                Positioned(
                  child: Container(
                    width: 50,
                    height: 50,
                    // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)), color: kBlueColor),

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
                                  overflow: TextOverflow.visible
                                  ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                              '\$'+ room.price + " /Monthly",
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
                          onPressed: () {
                            
                          },
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
                            "Apt# " +room.apartmentNumber,
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
                              Strings.imageurl+ room.user.profilePhoto,
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
                               room.user.firstName +" "+ room.user.lastName,
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
                          context: context,builder: (_) => NetworkGiffyDialog(
                          image:Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif"),
                          title: Text('Granny Eating Chocolate',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600)),
                          description:Text('This is a granny eating chocolate dialog box. This library helps you easily create fancy giffy dialog',
                          textAlign: TextAlign.center,
                          ),
                          entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                          onOkButtonPressed: () {},
                        ) );
                          },
                          color: kBlueColor,
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
}
