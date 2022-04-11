import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../screens/detail.dart';
import '../widgets/primary_card.dart';
import '../widgets/secondary_card.dart';

class MusicTabView extends StatelessWidget {
  late  List news;
  MusicTabView(this.news);
  @override
  initState(){
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
          child: PrimaryCard(datas: trending),
        ),
      );
    },
  );
}
}