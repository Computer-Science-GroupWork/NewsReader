import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsreader/screens/detail.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../widgets/secondary_card.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');

  String hintText = 'enter';
  late List news =[];

  Future<List> getNews(String search) async {
    print('vaaaaaaaaaaaaaaaaaaaal ${search}');
    String newsURL =
        'https://api.newscatcherapi.com/v2/search?q=${search}&lang=en';
    print('vaaaaaaaaaaaaaaaaaaaal ${newsURL}');

    final response = await http.get(
      Uri.parse(newsURL),

      // Send authorization headers to the backend.
      headers: {'x-api-key': '9OcCDjXqxKPoNc0JRy3BSfEi79fvPiARLuVbSesDYf0'},
    );

    if (response.statusCode == 200) {
      print('news issssssssssssssssssss ${response.body}');
       setState(() {
         news = jsonDecode(response.body)['articles'];
       });
    //_runFilter(search);
      print('newses issssssssssssssssssss ${news}');
      return news;
    } else {
      throw "Unable to retrieve news";
    }
  }
  @override

    Widget build(BuildContext context) {
      return Scaffold(


          appBar:
          AppBar(title: customSearchBar,
            titleTextStyle:GoogleFonts.lato(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 20),                          //fontWeight: FontWeight.bold,
             backgroundColor: kGrey2,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: customIcon,
                onPressed: () {
                  setState(() {               // Perform set of instructions.


                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar =  ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),

                          title:Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(10,0,0,0),
                            width: 600,
                            decoration: const BoxDecoration(


                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            child:
                            TextField(

                              // focusNode: focusNode,

                              onChanged:(value) => getNews(value),
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                hintText: hintText,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),)
                      );
                    } else {
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Search');

                    }

                  });

                },
              ),
            ],),
          backgroundColor: fBackgroundColor,
    body:

    Container(
    child: news.isNotEmpty?
        ListView.builder(
        itemCount: news.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var recent = news[index];

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
      ):Container(
    child: Center(
    child:const Text(
    'No results found',
    style: TextStyle(fontSize: 24),
    ),
    )

    )));
    }
//   void _runFilter(String enteredKeyword) {
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = news;
//     } else {
//       results = news
//           .where((home) =>
//           home["summary"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//
//       print("results are $results");
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//
//     // Refresh the UI
//     setState(() {
//       _found = results;
//       print(" results are $results");
//     });
//   }
}

