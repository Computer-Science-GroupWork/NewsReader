import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../screens/detail.dart';
import '../widgets/primary_card.dart';
import '../widgets/secondary_card.dart';

class MusicTabView extends StatefulWidget {
  late  List news;
  MusicTabView(this.news);

  @override
  State<MusicTabView> createState() => _MusicTabViewState();
}

class _MusicTabViewState extends State<MusicTabView> {


  List music = [];
  List found =[];

  @override
  initState(){
    runfilter();

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: found.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var trending = found[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(datas: trending),
              ),
            );
          },
          child:found.isNotEmpty?
          Container(
            width: double.infinity,
            height: 300.0,
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child:
            PrimaryCard(datas: trending),

          ): Container(
              child: Center(
                child:const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              )

          ),
        );
      },
    );
  }

  void runfilter()  {
    for(int i=0;i<widget.news.length;i++){
      print('ddddddddddd ${widget.news.length}');
      print('nwwwwwwwwwwwwwwwwws ${widget.news[i]['topic']}');
      if(((widget.news[i]['topic']).toString()).contains('music')){
        music.add(widget.news[i]);
      }
    };
    setState(() {
      found=music;
      print('techhhjhhhhhhhhhhhh is ${music}');


    });


  }
}