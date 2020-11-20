import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:homebound/helpers/colors.dart';
import 'package:homebound/models/advertisment.dart';
import 'package:homebound/models/rooms.dart';
import 'package:homebound/providers/theme.dart';
import 'package:homebound/services/api_manager.dart';
import 'package:homebound/widgets/popular_place.dart';
import 'package:homebound/widgets/recommended_card.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;

  final myController = TextEditingController();
  TextEditingController _searchController = new TextEditingController();
  Future<AvertisementModel> _avertisementModel;
  var response;
  var string = "empty_string";

  initiateSearch(value) {
    if (value == "") {
      string = "empty_string";
      setState(() {
        _avertisementModel = APIManager().getListing(string);
      });
    } else {
      // string = value;
      print(value);
      setState(() {
        _avertisementModel = APIManager().getListing(string);
      });
    }
  }

  @override
  void initState() {
    _avertisementModel = APIManager().getListing(string);
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "HomeBound",
                    style: theme.textTheme.subtitle2,
                  ),
                  subtitle: Text(
                    "The key to your home",
                    style: theme.textTheme.headline3.copyWith(height: 1.5),
                  ),
                  trailing: InkWell(
                      onTap: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                      child: Icon(Icons.brightness_6_outlined)),
                ),

                Container(
                  width: double.infinity,
                  height: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.only(left: 15, right: 8, top: 1),
                  child: TextField(
                    onChanged: (text) {
                      if (text == '') {
                        initiateSearch('empty_string');
                      } else {
                        initiateSearch(text);
                      }
                    },
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
                // Row(
                //   children: <Widget>[
                //     SizedBox(width: 25.0),

                //     SizedBox(height: 8.0),

                //   ],
                // )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 340.0,
              child: ListView.builder(
                itemCount: roomList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var room = roomList[index];
                  return RecommendedCard(room: room);
                },
              ),
            ),
            SizedBox(height: 15.0),
            ListTile(
              title: Text("Popular Place", style: theme.textTheme.headline3),
              
            ),
            FutureBuilder<AvertisementModel>(
                future: _avertisementModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // this is two
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.advertisments.length,
                      itemBuilder: (context, index) {
                        var advert = snapshot.data.advertisments[index];
                        var image = snapshot.data.images[index];
                        return PopularPlaceCard(advertisement: advert, image:image);
                      },
                    );
                  } else {
                    return Center(
                      child: Container(
                          width: 160,
                          height: 180,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  backgroundColor:
                                      Color.fromRGBO(58, 66, 86, 1.0),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                                width: 80,
                                height: 80,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text('Searching......'),
                              ),
                              DelayedDisplay(
                                delay: Duration(seconds: 1),
                                child: Text(
                                  "No results, please search again",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    );
                  }
                }),
          ]),
        ));
  }
}
