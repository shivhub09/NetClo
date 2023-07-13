import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/privacy.dart';

class Seasons extends StatefulWidget {
  final String title;
  final int id;

  Seasons({required this.title, required this.id});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  List<String> shortNames = [];
  List<int> episodes = [];
  List<int> seasonId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                widget.title,
                style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 30),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: shortNames.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Season ${index + 1}",
                            style: GoogleFonts.bebasNeue(
                                color: Colors.white, fontSize: 30),
                          ),
                          // Text(
                          //   seasonId[index].toString(),
                          //   style: GoogleFonts.bebasNeue(
                          //       color: Colors.white, fontSize: 30),
                          // ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Seasons(
                                      title: widget.title, id: widget.id),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
            )
          ],
        )));
  }

  void fetchData() async {
    var url = Uri.parse('https://netflix-data.p.rapidapi.com/title/seasons/');
    var queryParams = {
      'ids': widget.id.toString(),
      'offset': '0',
      'limit': '25',
    };
    var headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    var response = await http.get(url.replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data is List) {
        for (var item in data) {
          if (item['seasons'] is List) {
            for (var season in item['seasons']) {
              if (season['shortName'] is String &&
                  season['length'] is int &&
                  season['length'] is int) {
                setState(() {
                  shortNames.add(season['shortName']);
                  episodes.add(season['length']);
                  seasonId.add(season['seasonId']);
                });
              }
            }
          }
        }
      }
    } else {
      print('Error: ${response.statusCode}');
    }

    print(shortNames);
    print(episodes);
    print(seasonId);
  }
}
