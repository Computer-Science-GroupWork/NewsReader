import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsreader/screens/detail.dart';

import '../constants.dart';
import '../widgets/primary_card.dart';
import '../widgets/secondary_card.dart';

class PopularTabView extends StatefulWidget {
  late  List news;
  PopularTabView(this.news);
  @override
  State<PopularTabView> createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {
  List popularList=[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            padding: EdgeInsets.only(left: 18.0),
            child: ListView.builder(
              itemCount: widget.news.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var news = widget.news[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(datas: news),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: PrimaryCard(datas: news,),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 25.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text("BASED ON YOUR READING HISTORY",
                  style: kNonActiveTabStyle),
            ),
          ),
          ListView.builder(
            itemCount: widget.news.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var recent = widget.news[index];
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
                  margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: SecondaryCard(datas: recent),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}