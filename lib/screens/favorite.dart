import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:newsreader/models/news.dart';
import 'package:newsreader/screens/detail.dart';
import 'package:newsreader/screens/search.dart';

import '../constants.dart';
import '../widgets/secondary_card.dart';
import 'home.dart';
import 'international.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('likes');
  static List? data=[];
  static List? newdata=[];
  late  Box box1;
  late String userId;

  Widget customSearchBar = const Text('Favorites');

  getIds()async{
    box1 = await Hive.openBox('newsapps');
    getFavorites();
  }

  @override
  initState(){
    getIds();
getFavorites();
  }
  getFavorites() async {
    userId=box1.get('userId');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    data = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('daaaaaaaaaaaaaaaaaaa ${data}');

    newdata=data
        !.where((uid) =>
        uid["likerid"].contains(userId))
        .toList();
    setState(() {
      data=newdata;
    });
    // for (int i = 0; i < data!.length; i++) {
    //   NewsModel newsModel = new NewsModel();
    //   newsModel.likerid = data![i]["likerid"];
    //   newsModel.title = data![i]["title"];
    //   newsModel.author = data![i]["clean_url"];
    //   newsModel.description = data![i]["excerpt"];
    //   newsModel.urlToImage = data![i]["link"];
    //   newsModel.summary = data![i]["summary"];
    //   newsModel.publishedAt = data![i]["published_date"];
    //   newsModel.topic = data![i]["topic"];
   // }
  }
  int _selectedIndex = 2; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => International()));
      } else if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Favorite()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Search()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          titleTextStyle: GoogleFonts.lato(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 20), //fontWeight: FontWeight.bold,
          backgroundColor: kGrey2,
          automaticallyImplyLeading: false,

        ),
        backgroundColor: fBackgroundColor,
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50)),
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
                      icon: Icon(Icons.favorite_outline),
                      label: 'Favorite',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                  ],
                  currentIndex: _selectedIndex, //New
                  onTap: _onItemTapped,
                ))),
        body: Container(
            child: data!.isNotEmpty?
            ListView.builder(
                    itemCount: data?.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var recent = data?[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(datas: recent),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 135.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8.0),
                          child: SecondaryCard(datas: recent),
                        ),
                      );
                    },
                  )
                : Container(
                    child: Center(
                    child: const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
                  ))));
  }
}
