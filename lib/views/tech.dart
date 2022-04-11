import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../screens/detail.dart';
import '../widgets/primary_card.dart';
import '../widgets/secondary_card.dart';

class TechTabView extends StatefulWidget {
  late  final List newss;

  TechTabView(this.newss);

  @override
  State<TechTabView> createState() => _TechTabViewState();
}

class _TechTabViewState extends State<TechTabView> {
  List tech = [];
   List found=[];

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
          child: Container(
            width: double.infinity,
            height: 300.0,
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            child:trending.isNotEmpty?
            PrimaryCard(datas: trending):
            Container(
                child: Center(
                  child:const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
                )

            ),
          ),
        );
      },
    );
  }

  void runfilter()  {
  for(int i=0;i<widget.newss.length;i++){
    print('ddddddddddd ${widget.newss.length}');
    print('nwwwwwwwwwwwwwwwwws ${widget.newss[i]['topic']}');
     if(((widget.newss[i]['topic']).toString()).contains('news')){
       tech.add(widget.newss[i]);
     }
  };
  setState(() {
    found=tech;
     print('techhhjhhhhhhhhhhhh is ${tech}');


  });


     }
}