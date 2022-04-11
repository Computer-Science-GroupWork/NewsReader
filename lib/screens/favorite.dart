import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:newsreader/models/news.dart';
import 'package:newsreader/screens/detail.dart';

import '../constants.dart';
import '../widgets/secondary_card.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('likes');
  static List? data=[];
  late  Box box1;
  late String userId;

  Widget customSearchBar = const Text('Favorites');

  getIds()async{
    box1 = await Hive.openBox('newsapp');
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

    data
        !.where((uid) =>
        uid["likerid"].contains(userId))
        .toList();
    setState(() {
      data=data;
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
