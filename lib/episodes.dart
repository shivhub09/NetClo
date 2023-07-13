import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/privacy.dart';
import 'package:http/http.dart' as http;

class Episodes extends StatefulWidget {
  const Episodes({super.key});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  List<dynamic> episodes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          FloatingActionButton(onPressed: () {
            fetchData();
          }),
          Expanded(
            child: ListView.builder(
                itemCount: episodes.length,
                itemBuilder: ((context, index) {
                  final episode = episodes[index];
                  final title = episode["title"];
                  return Text(title);
                })),
          )
        ],
      )),
    );
  }

  void fetchData() async {
    var url = Uri.parse('https://netflix-data.p.rapidapi.com/season/episodes/');
    var queryParams = {'ids': '80186799', 'offset': '0', 'limit': '25'};
    var headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    var response = await http.get(url.replace(queryParameters: queryParams),
        headers: headers);
    // print(response.body);

    final json = jsonDecode(response.body);
    episodes = json[0]["episodes"];
    print(episodes.length);
    print(episodes[0]["title"]);
  }
}
