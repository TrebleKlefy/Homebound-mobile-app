import 'package:flutter/material.dart';
import 'package:homebound/constants/strings.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:homebound/views/advert_details.dart';


class RecommendedCard extends StatelessWidget {
  

  final Advertisment advertisement;
  final List<Imagery> image;
  RecommendedCard({this.advertisement, this.image});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
     if( advertisement.feature ==1 ){
    return Card(
      margin: EdgeInsets.only(left: 18.0, bottom: 8.0),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
  
      child: GestureDetector(
        onTap: () {
         
          Navigator.push(
          context,
          new MaterialPageRoute(
          builder: (context) => DetailOfHouse(advertisement,image),
              ));
              },
              child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.network(
              Strings.imageurl + advertisement.photoName,
                fit: BoxFit.cover,
                width: 200.0,
                height: 180.0,
              ),
            ),
            Container(
              width: 160.0,
              height: 130.0,
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                advertisement.name,
                    maxLines: 2,
                    style: theme.textTheme.headline4,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    advertisement.street,
                    maxLines: 2,
                    style: theme.textTheme.subtitle2,
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Text(
                        "\$"+advertisement.price,
                        style:
                            theme.textTheme.headline3.copyWith(color: kBlueColor),
                      ),
                      Spacer(),
                      Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              kErrorDarkColor,
                              kErrorLightColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.errorColor.withOpacity(.7),
                              blurRadius: 15.0,
                              spreadRadius: 0.2,
                              offset: Offset(0, 8),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.bookmark,
                          color: kBackgroundLightColor,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
     }else{return Container();}
  }
}
