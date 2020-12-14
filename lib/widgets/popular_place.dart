import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:homebound/views/advert_details.dart';

class PopularPlaceCard extends StatelessWidget {
  final Advertisment advertisement;
  final List<Imagery> image;
  PopularPlaceCard({this.advertisement, this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 90.0,
      margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => DetailOfHouse(advertisement, image),
              ));
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 90.0,
              height: 90.0,
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 12.0,
                    bottom: 12.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        Strings.imageurl + advertisement.photoName,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: kBlueColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 3.0),
                            Text('\$ ' + advertisement.price,
                                style: theme.textTheme.headline5
                                    .copyWith(color: kPrimaryDarkColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(advertisement.name,
                        style: theme.textTheme.headline3, maxLines: 1),
                    Text(advertisement.street,
                        style: theme.textTheme.subtitle2),
                    Container(
                      margin: EdgeInsets.only(right: 65),
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
                                advertisement.contract,
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
                                advertisement.rooms.toString() + " Bed Rooms",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
