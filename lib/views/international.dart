import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/detail.dart';
import '../widgets/primary_card.dart';

class InternationalTabView extends StatelessWidget {
  late  List news;
  late List inter ;
  InternationalTabView(this.news);

@override
  initState(){
    runfilter();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var trending = news[index];

        return InkWell(
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(datas: trending),
            ),
          );

          },
          child: Container(
            width: double.infinity,
            height: 300.0,
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child: PrimaryCard(datas: inter),
          ),
        );
      },
    );
  }
  void runfilter() {
     inter = [];
    news.forEach((u) {
      if(u["topic"]=='international')
        inter.add(u);
    });  }
}
