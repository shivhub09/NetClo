import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isLoading = false;
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          floatingActionButton: FloatingActionButton(
            onPressed: fetchData,
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(color: Colors.black),
                    height: 70,
                    child: Image.asset(
                      "assets/netflix logo.png",
                      fit: BoxFit.fill,
                    )),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Set the number of columns
                    ),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final title = user['jawSummary']['title'];
                      final photo =
                          user['jawSummary']['backgroundImage']['url'];
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.all(8),
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              photo,
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void fetchData() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': 'netflix',
        'offset': '0',
        'limit_titles': '50',
        'limit_suggestions': '50',
      },
    );

    final headers = {
      'X-RapidAPI-Key': '682d0337cemshd966d21fce23698p19ef72jsn6d730c813e9f',
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    print(url);

    final response = await http.get(url, headers: headers);
    print(response.body);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json["titles"];
    });
    print("loading");
    print(users);
  }
}
