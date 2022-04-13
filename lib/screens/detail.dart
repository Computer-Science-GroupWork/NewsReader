import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../models/news.dart';

class DetailPage extends StatefulWidget {
  final  datas;

  const DetailPage({Key? key, @required this.datas}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late bool status=false;
  late  Box box1;
  late bool speaker = false;
  late String userId;
  TextToSpeech tts = TextToSpeech();

  @override
  initState(){
    getId();
  }
  getId()async{
    box1 = await Hive.openBox('newsapps');

     // box1.clear();
  }
  getTitle() {
    return widget.datas?['title'];
  }

   getAuthor() {
    return widget.datas['clean_url'];
  }

  getDescription() {
    return widget.datas?['excerpt'];
  }

   getPublishAt() {
    return widget.datas?['published_date'];
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
                      String content='${widget.datas['title']} ${widget.datas['link']} ${widget.datas['excerpt']}';

                        Share.share(content);
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
                      status ? addFavorite(widget.datas):signInAnonymously();
                    // if(userId? != null){
                    //
                    // }else{
                    //   getId();
                    // }


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
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if(speaker == true){
                      tts.stop();
                      speaker=false;
                    }else{
                      speak();
                    }

                  },
                  child: Icon(Icons.campaign_outlined, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(13),
                    primary: Colors.white, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
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
                Flexible(child:
                Text(
                  getAuthor().toString(),
                  style: kDetailContent.copyWith(color: Colors.black),
                ),)
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

   signInAnonymously() async{
    await _auth.signInAnonymously().then((result) {
      setState(() {
        box1.put('userId', result.user?.uid);
        userId = box1.get('userId');

        // final User user = result.user;
      });
    });
    if (userId != null){
      status= true;
      print('ussssssssssssssssr ${userId}');
      addFavorite(widget.datas);
    }else{
      signInAnonymously();
      status=false;
    }


  }

  void addFavorite(datas) async{
    var uid = Uuid().v1();

    NewsModel newsModel = new NewsModel();
    newsModel.likerid=userId;
    newsModel.title=widget.datas['title'];
    newsModel.author=widget.datas['clean_url'];
    newsModel.excerpt=widget.datas['excerpt'];
    newsModel.link=widget.datas['link'];
    newsModel.media=widget.datas['media'];
    newsModel.summary=widget.datas['summary'];
    newsModel.published_date= widget.datas['published_date'];
    newsModel.topic=widget.datas['topic'];
    await firebaseFirestore
        .collection("likes")
        .doc(uid)
        .set(newsModel.toMap());
    // setState(() {
    //   showSpinner = false;
    // });
    Fluttertoast.showToast(msg: "Favorite added successfully :) ");
  }

  Future<void> speak() async {
     speaker = true;
    String reader='${getTitle()} ${getSummary()}';
    print('reader isssssssssssssssssss ${reader}');
    await tts.setPitch(1.0);
    await tts.setRate(0.7);
    await tts.setLanguage('en-US');
    await tts.speak(reader);

  }

}

