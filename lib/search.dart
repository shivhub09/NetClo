import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  List<dynamic> users = [];
  List<dynamic> reversed = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextFormField Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  fetchdata();
                },
                child: Text('Submit'),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = reversed[index];
                          final title = user['jawSummary']['title'];
                          final photo =
                              user['jawSummary']['backgroundImage']['url'];
                          final description = user['jawSummary']['synopsis'];
                          final imageurl =
                              user['jawSummary']['backgroundImage']['url'];
                          final logoimgurl =
                              user['jawSummary']['logoImage']['url'];
                          List<Map<String, dynamic>> genres =
                              (user['jawSummary']['genres'] as List<dynamic>)
                                  .cast<Map<String, dynamic>>();
                          List<String> genrelist = genres
                              .map((item) => item["name"] as String)
                              .toList();
                          List<Map<String, dynamic>> castlist =
                              (user['jawSummary']['cast'] as List<dynamic>)
                                  .cast<Map<String, dynamic>>();
                          List<String> cast = castlist
                              .map((item) => item["name"] as String)
                              .toList();
                          return SizedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 280,
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Details(
                                              title: title,
                                              desc: description,
                                              backgroundimg: imageurl,
                                              logoimgurl: logoimgurl,
                                              genres: genrelist,
                                              castlist: cast,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          photo,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchdata() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': _name,
        'offset': '0',
        'limit_titles': '3',
        'limit_suggestions': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': '682d0337cemshd966d21fce23698p19ef72jsn6d730c813e9f',
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json["titles"];
      reversed = users.reversed.toList();
      isLoading = false;
    });
  }
}
