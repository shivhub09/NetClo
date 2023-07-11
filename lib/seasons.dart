import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_clone/privacy.dart';
import 'package:http/http.dart' as http;

class Seasons extends StatefulWidget {
  const Seasons({super.key});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  List<dynamic> users = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FloatingActionButton(
        onPressed: fetchData,
      )),
    );
  }

  void fetchData() async {
    var url = Uri.parse('https://netflix-data.p.rapidapi.com/title/seasons/');
    var queryParams = {
      'ids': '80057281',
      'offset': '0',
      'limit': '25',
    };
    var headers = {
      'X-RapidAPI-Key': '2bc4734294msh9a6f39f794484e3p1785cbjsn26e47015da1a',
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    var response = await http.get(url.replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}
