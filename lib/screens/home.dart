import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:newsreader/models/weather.dart';
import 'package:newsreader/screens/detail.dart';
import 'package:newsreader/screens/international.dart';
import 'package:newsreader/screens/search.dart';
import 'package:newsreader/screens/weather.dart';
import 'package:newsreader/views/music.dart';
import 'package:newsreader/views/popular.dart';

import '../constants.dart';
import '../models/news.dart';
import '../views/business.dart';
import '../views/entertainment.dart';
import '../views/politiics.dart';
import '../views/sport.dart';
import '../views/tech.dart';
import 'favorite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static late Position currentPosition;
  late Address addresses;
  late String? location;
  late LatLng _center;
  late  WeatherModel weather;
  late  List news;
  late String weatherURL;
  @override
  void initState() {
    setState(() {});
  }

  Future<List> getNews(String search) async {
    String newsURL =
        'https://api.newscatcherapi.com/v2/${search}?countries=ug&lang=en';
    final response = await http.get(
      Uri.parse(newsURL),

      // Send authorization headers to the backend.
      headers: {'x-api-key': '9OcCDjXqxKPoNc0JRy3BSfEi79fvPiARLuVbSesDYf0'},
    );

    if (response.statusCode == 200) {
      print('news issssssssssssssssssss ${response.body}');
      // setState(() {
        news = jsonDecode(response.body)['articles'];

      // });


      //print('newses issssssssssssssssssss ${body}');
      // news=NewsModel.fromJson(body) as List;
      // news = body.map((article) => NewsModel.fromJson(article)).toList() ;
      // weather = body.main;
      print('newses issssssssssssssssssss ${news}');

      return news;
    } else {
      throw "Unable to retrieve news";
    }
  }

  Future<WeatherModel> getWeather() async {
    currentPosition = await _determinePosition();

    GeoCode geoCode = GeoCode();
    try {
      addresses = await geoCode.reverseGeocoding(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude);

      var first = addresses.city;
      print("${addresses.city} : ${addresses.countryName}");
      location = addresses.city;
    } catch (e) {
      print(e);
    }
    weatherURL =
        'https://community-open-weather-map.p.rapidapi.com/weather?q=${addresses.city}';

    final response = await http.get(
      Uri.parse(weatherURL),

      // Send authorization headers to the backend.
      headers: {
        'X-RapidAPI-Host': 'community-open-weather-map.p.rapidapi.com',
        'X-RapidAPI-Key': 'f1456fc294mshb683511e7e6e855p1d89f4jsn4191422febae'
      },
    );
    print('datas issssssssssssssssssss ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)['main'];
      ;
      print('wethar issssssssssssssssssss ${body}');

      weather = WeatherModel.fromJson(body);

      // weather = body.main;
       print('weathers issssssssssssssssssss ${weather}');
      await getNews('latest_headlines');

      return weather;
    } else {
      throw "Unable to retrieve weather";

    }
  }


  String getTitle(index) {
    return news[index]['title'];
  }

  String getAuthor(index) {
    return news[index]['clean_url'];
  }

  String getDescription(index) {
    return news[index]['excerpt'];
  }

  String getPublishAt(index) {
    return news[index]['published_date'];
  }
  int getLength() {
    return news.length;
  }
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => International()));
      } else if(index == 2){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WeatherPage()));
      }else  {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Search()));}
    });
  }

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
        length: 7,
      child:Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "WELCOME",
                textAlign: TextAlign.end,
                style: kNonActiveTabStyle,
              ),
              subtitle: Text(
                "Jessica Veranda",
                textAlign: TextAlign.end,
                style: kActiveTabStyle,
              ),
              // trailing: Container(
              //   width: 50.0,
              //   height: 50.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.0),
              //     image: DecorationImage(
              //       image: AssetImage("assets/ve.jpg"),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: kGrey1,
                unselectedLabelStyle: kNonActiveTabStyle,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                indicatorColor: Colors.white,
                labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                tabs: [
                  Tab(text: "Popular"),

                  Tab(text: "Tech"),
                  Tab(text: "Politics"),
                  Tab(text: "Sport"),

                  Tab(text: "Business"),

                  Tab(text: "Entertainment"),
                  Tab(text: "Music"),


                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: BottomNavigationBar(
                // selectedFontSize: 20,
                // selectedIconTheme:
                // IconThemeData(color: fButtonColor, size: 40),
                // selectedItemColor: fButtonColor,
                // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                // backgroundColor: fBackgroundColor,
                // unselectedItemColor: Colors.black,
                backgroundColor: Colors.white,
                // currentIndex: _selectedIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Local',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.flight),
                    label: 'International',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cloud),
                    label: 'Weather',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'search',
                  ),
                ],
                currentIndex: _selectedIndex, //New
                onTap: _onItemTapped,
              ))),
      body:  FutureBuilder(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              return TabBarView(
                children: [
                  PopularTabView(news),
                  TechTabView(news),
                  PoliticsTabView(news),
                  SportsTabView(news),
                  BusinessTabView(news),
                  EntertainmentTabView(news),
                  MusicTabView(news),

                ],
              );
              // return Column(
              //
              // children:[
              //  // Expanded(child:
              //   SizedBox(
              //     height: 80,
              //   ),
              //   Container(
              //     height: 50,
              //     margin: EdgeInsets.all(30),
              //
              //     decoration: const BoxDecoration(
              //         color: Colors.green,
              //         borderRadius: BorderRadius.all(Radius.circular(30))),
              //        child:TextField(
              //       // focusNode: focusNode,
              //
              //       onChanged:(value) => getNews(value),
              //       decoration: InputDecoration(
              //         hintText: 'Search',
              //         hintStyle: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //           fontStyle: FontStyle.italic,
              //         ),
              //         border: InputBorder.none,
              //       ),
              //       style: TextStyle(
              //         color: Colors.black,
              //       ),
              //     ) ,
              //   ),
              //  // Expanded(child:
              //   Container(
              //     child: Card(
              //       elevation: 2.0,
              //       child: Column(
              //         children: [
              //           ListTile(
              //             title: Text((weather.temp).toString()),
              //             subtitle: Text((weather.feels_like).toString()),
              //             trailing:Text((weather.temp_min).toString()),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              //   Expanded(child:
              //   ListView.builder(
              //     shrinkWrap: true,
              //   padding: const EdgeInsets.all(4.5),
              //   itemCount: this.getLength(),
              //   itemBuilder: _itemBuilder,
              // )),]);
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getWeather(),
      ),
    ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return
      Card(
        elevation: 2.0,
        child: Column(
          children: [
            ListTile(
              title: Text(getTitle(index)),
              subtitle: Text(getDescription(index)),
              // trailing: Icon(Icons.favorite_outline),
            ),
            Container(
              padding: EdgeInsets.only(right: 30, left: 30),
              height: 100.0,
              child:
              Image.network((news[index]['media']) ?? 'https://s3.ap-southeast-1.amazonaws.com/images.asianage.com/images/aa-Cover-fp0p1pcb1uqec36nc6fpphf6o3-20220408013101.jpeg' ),

            ),
            Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.centerLeft,
              child: Text(getAuthor(index)),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('LEARN MORE'),
                  onPressed: () {
                    NewsModel newsModel= new NewsModel();
                    newsModel.author=news[index]['author'];
                    newsModel.title=news[index]['title'];
                    newsModel.description=news[index]['excerpt'];
                    newsModel.urlToImage=news[index]['media'];
                    newsModel.summary=news[index]['summary'];
                    newsModel.topic=news[index]['topic'];
                    newsModel.publishedAt=news[index]['published_date'];
                    newsModel.url=news[index]['link'];
                    // newsModel.title=news[index]['title'];
                    // newsModel.title=news[index]['title'];

                    // Map<String, dynamic> as = newsModel.toMap();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(datas: newsModel)));
                  },
                )
              ],
            )
          ],
        ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getSearch(String value) {

  }
}
