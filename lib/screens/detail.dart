import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';

class DetailPage extends StatefulWidget {
  final NewsModel? datas;

  const DetailPage({Key? key, @required this.datas}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? getTitle() {
    return widget.datas!.title;
  }

  String? getAuthor() {
    return widget.datas!.author;
  }

  String? getDescription() {
    return widget.datas!.description;
  }

  String? getPublishAt() {
    return widget.datas!.publishedAt;
  }

  String? getDetail() {
    return widget.datas!.summary;
  }
  String? getSummary() {
    return widget.datas!.summary;
  }
  String? getTopic() {
    return widget.datas!.topic;
  }
  String? getUrl() {
    return widget.datas!.url;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child:SingleChildScrollView(

        child:Column(
          children: [
            Container(
              child: Image.network((widget.datas?.urlToImage).toString()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(getTitle().toString()),
            ),
            SizedBox(
              height: 20,

            ),

            Container(
              child: Text(getSummary().toString()),
            ),
            SizedBox(
              height: 20,

            ),

            Container(
                    child: Text(getAuthor().toString()),

                  ),
            SizedBox(
              height: 20,
            ),

            Container(
                    child: Text(getPublishAt().toString()),

                  ),
            Container(
              child: Text(getUrl().toString()),

            ),


          ],
        ),)
        
      ),
    );
  }
}
