import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/news.dart';

class DetailPage extends StatefulWidget {
  final  datas;

  const DetailPage({Key? key, @required this.datas}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
   getTitle() {
    return widget.datas?['title'];
  }

   getAuthor() {
    return widget.datas['author'];
  }

  getDescription() {
    return widget.datas?['excerpt'];
  }

   getPublishAt() {
    return widget.datas?['publishedAt'];
  }
  //
  // String? getDetail() {
  //   return widget.datas!.summary;
  // }

   getSummary() {
    return widget.datas?['summary'];
  }

   getTopic() {
    return widget.datas?['topic'];
  }

   getUrl() {
    return widget.datas?['link'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  // CircleButton(
                  //   icon: Icons.arrow_back_ios,
                  //   onTap: () => Navigator.pop(context),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  Spacer(),
                  // CircleButton(
                  //   icon: Icons.share,
                  //   onTap: () {},
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.share, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(13),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                  // CircleButton(
                  //   icon: Icons.favorite_border,
                  //   onTap: () {},
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.favorite_border, color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 12.0),
            Hero(
              tag: (widget.datas['_id']).toString(),
              child: Container(
                height: 220.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage((widget.datas['media']).toString()
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 15.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kGrey3, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 5.0,
                        backgroundColor: kGrey3,
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        (widget.datas?['topic']).toString(),
                        style: kCategoryTitle,
                      ),
                    ],
                  ),
                ),
              //   Spacer(),
              //   Status(
              //     icon: Icons.remove_red_eye,
              //     total: news.seen,
              //   ),
              //   SizedBox(width: 15.0),
              //   Status(
              //     icon: Icons.favorite_border,
              //     total: news.favorite,
              //   ),
               ],
            ),
            SizedBox(height: 12.0),
            Text(getTitle().toString(), style: kTitleCard.copyWith(fontSize: 28.0)),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text(getPublishAt().toString(), style: kDetailContent),
                SizedBox(width: 5.0),
                SizedBox(
                  width: 10.0,
                  child: Divider(
                    color: kBlack,
                    height: 1.0,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  getAuthor().toString(),
                  style: kDetailContent.copyWith(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              getSummary().toString(),
              style: descriptionStyle,
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }
  //   return Container(
  //     child: Card(
  //       child:SingleChildScrollView(
  //
  //       child:Column(
  //         children: [
  //           Container(
  //             child: Image.network((widget.datas?.urlToImage).toString()),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Container(
  //             child: Text(getTitle().toString()),
  //           ),
  //           SizedBox(
  //             height: 20,
  //
  //           ),
  //
  //           Container(
  //             child: Text(getSummary().toString()),
  //           ),
  //           SizedBox(
  //             height: 20,
  //
  //           ),
  //
  //           Container(
  //                   child: Text(getAuthor().toString()),
  //
  //                 ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //
  //           Container(
  //                   child: Text(getPublishAt().toString()),
  //
  //                 ),
  //           Container(
  //             child: Text(getUrl().toString()),
  //
  //           ),
  //
  //
  //         ],
  //       ),)
  //
  //     ),
  //   );
  // }
}
