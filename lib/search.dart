import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/details.dart';

class Search extends StatefulWidget {
  late String searchtext;
  Search({required this.searchtext});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> users = [];
  List<dynamic> reversedlist = [];
  bool isLoading = true;
  String api = "true";
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(color: Colors.black),
                height: 70,
                child: Image.asset(
                  "assets/netflix logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
              child: Text(
                "Search Related to : ${widget.searchtext}",
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = reversedlist[index];
                        final title = user['jawSummary']['title'];
                        final photo =
                            user['jawSummary']['backgroundImage']['url'];
                        final description = user['jawSummary']['synopsis'];
                        final type = user['summary']['type'];
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
                              SizedBox(
                                height: 280,
                                width: 160,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: GoogleFonts.bebasNeue(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                      Text(
                                        type,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Flexible(
                                          child: Text(
                                        description,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchdata() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': widget.searchtext,
        'offset': '0',
        'limit_titles': '10',
        'limit_suggestions': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': api,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json["titles"];
      reversedlist = users.reversed.toList();
      isLoading = false;
    });
  }
}
