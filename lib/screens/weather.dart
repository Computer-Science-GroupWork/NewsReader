import 'package:flutter/cupertino.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:newsreader/screens/search.dart';
// import 'package:newsreader/screens/weather.dart';
// import 'package:newsreader/views/popular.dart';
//
// import '../constants.dart';
// import '../models/news.dart';
// import '../views/business.dart';
// import '../views/entertainment.dart';
// import '../views/music.dart';
// import '../views/politiics.dart';
// import '../views/sport.dart';
// import '../views/tech.dart';
// import 'detail.dart';
// import 'favorite.dart';
// import 'home.dart';
//
// class International extends StatefulWidget {
//   const International({Key? key}) : super(key: key);
//
//   @override
//   State<International> createState() => _InternationalState();
// }
//
// class _InternationalState extends State<International> {
//   late List news;
//
//   Future<List> getNews() async {
//     String newsURL =
//         'https://api.newscatcherapi.com/v2/latest_headlines?not_countries=ug&lang=en';
//     final response = await http.get(
//       Uri.parse(newsURL),
//
//       // Send authorization headers to the backend.
//       headers: {'x-api-key': '9OcCDjXqxKPoNc0JRy3BSfEi79fvPiARLuVbSesDYf0'},
//     );
//
//     if (response.statusCode == 200) {
//       print('news issssssssssssssssssss ${response.body}');
//
//       news = jsonDecode(response.body)['articles'];
//
//       print('newses issssssssssssssssssss ${news}');
//
//       return news;
//     } else {
//       throw "Unable to retrieve news";
//     }
//   }
//
//   String getTitle(index) {
//     return news[index]['title'];
//   }
//
//   String getAuthor(index) {
//     return news[index]['clean_url'];
//   }
//
//   String? getDescription(index) {
//     return news[index]['excerpt'];
//   }
//
//   String getPublishAt(index) {
//     return news[index]['published_date'];
//   }
//
//   int getLength() {
//     return news.length;
//   }
//
//   int _selectedIndex = 1; //New
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 0) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => MyHomePage()));
//       } else if (index == 1) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => International()));
//       } else if (index == 2) {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => Favorite()));
//       } else {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => Search()));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 7,
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(120.0),
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     "WELCOME",
//                     textAlign: TextAlign.end,
//                     style: kNonActiveTabStyle,
//                   ),
//                   subtitle: Text(
//                     "Jessica Veranda",
//                     textAlign: TextAlign.end,
//                     style: kActiveTabStyle,
//                   ),
//                   // trailing: Container(
//                   //   width: 50.0,
//                   //   height: 50.0,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(10.0),
//                   //     image: DecorationImage(
//                   //       image: AssetImage("assets/ve.jpg"),
//                   //       fit: BoxFit.cover,
//                   //     ),
//                   //   ),
//                   // ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: TabBar(
//                     labelColor: Colors.black,
//                     unselectedLabelColor: kGrey1,
//                     unselectedLabelStyle: kNonActiveTabStyle,
//                     indicatorSize: TabBarIndicatorSize.label,
//                     isScrollable: true,
//                     indicatorColor: Colors.white,
//                     labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
//                     tabs: [
//                       Tab(text: "Popular"),
//
//                       Tab(text: "Tech"),
//                       Tab(text: "Politics"),
//                       Tab(text: "Sport"),
//                       Tab(text: "Business"),
//                       Tab(text: "Entertainment"),
//                       Tab(text: "Music"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           bottomNavigationBar: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(50),
//                     topLeft: Radius.circular(50)),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black38, spreadRadius: 0, blurRadius: 10),
//                 ],
//               ),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10.0),
//                     topRight: Radius.circular(10.0),
//                   ),
//                   child: BottomNavigationBar(
//                     backgroundColor: Colors.white,
//                     // currentIndex: _selectedIndex,
//                     showSelectedLabels: false,
//                     showUnselectedLabels: false,
//                     type: BottomNavigationBarType.fixed,
//
//                     items: const <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.home),
//                         label: 'Local',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.flight),
//                         label: 'International',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.favorite_outline),
//                         label: 'Favorite',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.search),
//                         label: 'Search',
//                       ),
//                     ],
//                     currentIndex: _selectedIndex, //New
//                     onTap: _onItemTapped,
//                   ))),
//           body: FutureBuilder(
//             builder: (ctx, snapshot) {
//               // Checking if future is resolved or not
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If we got an error
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       '${snapshot.error} occured',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   );
//
//                   // if we got our data
//                 } else if (snapshot.hasData) {
//                   // Extracting data from snapshot object
//                   return TabBarView(
//                     children: [
//                       PopularTabView(news),
//                       TechTabView(news),
//                       PoliticsTabView(news),
//                       SportsTabView(news),
//                       BusinessTabView(news),
//                       EntertainmentTabView(news),
//                       MusicTabView(news),
//                     ],
//                   );
//                 }
//               }
//
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//             future: getNews(),
//           ),
//         ));
//   }
//
//   Widget _itemBuilder(BuildContext context, int index) {
//     return Column(children: [
//       Card(
//           elevation: 2.0,
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(getTitle(index)),
//                 subtitle: Text(getDescription(index).toString()),
//                 // trailing: Icon(Icons.favorite_outline),
//               ),
//               Container(
//                 padding: EdgeInsets.only(right: 30, left: 30),
//                 height: 100.0,
//                 child: Image.network((news[index]['media']) ??
//                     'https://s3.ap-southeast-1.amazonaws.com/images.asianage.com/images/aa-Cover-fp0p1pcb1uqec36nc6fpphf6o3-20220408013101.jpeg'),
//               ),
//               Container(
//                 padding: EdgeInsets.all(5.0),
//                 alignment: Alignment.centerLeft,
//                 child: Text(getAuthor(index)),
//               ),
//               ButtonBar(
//                 children: [
//                   TextButton(
//                     child: const Text('LEARN MORE'),
//                     onPressed: () {
//                       NewsModel newsModel = new NewsModel();
//                       newsModel.author = news[index]['author'];
//                       newsModel.title = news[index]['title'];
//                       newsModel.excerpt = news[index]['excerpt'];
//                       newsModel.media = news[index]['media'];
//                       newsModel.summary = news[index]['summary'];
//                       newsModel.topic = news[index]['topic'];
//                       newsModel.published_date = news[index]['published_date'];
//                       newsModel.link = news[index]['link'];
//                       // newsModel.title=news[index]['title'];
//                       // newsModel.title=news[index]['title'];
//
//                       // Map<String, dynamic> as = newsModel.toMap();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => DetailPage(datas: newsModel)));
//                     },
//                   )
//                 ],
//               )
//             ],
//           ))
//     ]);
//   }
// }
