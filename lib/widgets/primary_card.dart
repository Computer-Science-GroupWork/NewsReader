
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/news.dart';

class PrimaryCard extends StatelessWidget {
  final  datas;
  PrimaryCard({required this.datas});

  String? getTitle() {
    return datas['title'];
  }

  String? getAuthor() {
    return datas['clean_url'];
  }

  String? getDescription() {
    return datas['excerpt'];
  }

  String? getPublishAt() {
    return datas['published_date'];
  }

  // String? getDetail() {
  //   return datas[''];
  // }

  String? getSummary() {
    return datas['summary'];
  }
   getTopic() {
    return datas['topic'];
  }

  String? getUrl() {
    return datas['link'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              SizedBox(width: 10.0),
              Text(getTopic().toString(), style: kCategoryTitle)
            ],
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: Hero(
              tag: getPublishAt().toString(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(datas['media'] ?? 'https://s3.ap-southeast-1.amazonaws.com/images.asianage.com/images/aa-Cover-fp0p1pcb1uqec36nc6fpphf6o3-20220408013101.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            getTitle().toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kTitleCard,
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                getPublishAt().toString(),
                style: kDetailContent,
              ),
              SizedBox(width: 10.0),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              SizedBox(width: 10.0),
             // Text("${get} min read", style: kDetailContent)
            ],
          )
        ],
      ),
    );
  }
}
