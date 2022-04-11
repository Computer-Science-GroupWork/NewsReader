import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/news.dart';

class SecondaryCard extends StatelessWidget {
  final datas;
  SecondaryCard({this.datas});
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

  String? getTopic() {
    return datas['topic'];
  }

  String? getUrl() {
    return datas['link'];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kGrey3, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 90.0,
            height: 135.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(datas['media'] ?? 'https://s3.ap-southeast-1.amazonaws.com/images.asianage.com/images/aa-Cover-fp0p1pcb1uqec36nc6fpphf6o3-20220408013101.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle().toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    getDescription().toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kDetailContent,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(getPublishAt().toString(), style: kDetailContent),
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        radius: 5.0,
                        backgroundColor: kGrey1,
                      ),
                      SizedBox(width: 10.0),
                      // Text(
                      //   "${news.estimate} min read",
                      //   style: kDetailContent,
                      // )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}