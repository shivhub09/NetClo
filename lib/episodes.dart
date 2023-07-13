import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/privacy.dart';
import 'package:http/http.dart' as http;

class Episodes extends StatefulWidget {
  final int episodeid;

  Episodes({required this.episodeid});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  List<dynamic> episodes = [];

  @override
  void initState() {
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
          Expanded(
            child: ListView.builder(
                itemCount: episodes.length,
                itemBuilder: ((context, index) {
                  final episode = episodes[index];
                  final title = episode["title"];
                  final imageurl = episode["interestingMoment"]["_342x192"]
                      ["webp"]["value"]["url"];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Text(title,
                            style: GoogleFonts.bebasNeue(
                                color: Colors.white, fontSize: 20)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(imageurl)),
                      ],
                    ),
                  );
                })),
          )
        ],
      )),
    );
  }

  void fetchData() async {
    var url = Uri.parse('https://netflix-data.p.rapidapi.com/season/episodes/');
    var queryParams = {
      'ids': widget.episodeid.toString(),
      'offset': '0',
      'limit': '25'
    };
    var headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    var response = await http.get(url.replace(queryParameters: queryParams),
        headers: headers);

    final json = jsonDecode(response.body);
    episodes = json[0]["episodes"];
  }
}
