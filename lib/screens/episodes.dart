import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/privacy.dart';
import 'package:http/http.dart' as http;

class Episodes extends StatefulWidget {
  final int episodeid;
  final int seasonid;

  Episodes({required this.episodeid, required this.seasonid});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  Future<List<dynamic>>? _fetchEpisodesFuture;

  @override
  void initState() {
    _fetchEpisodesFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  "Season " + widget.seasonid.toString(),
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _fetchEpisodesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final episodes = snapshot.data!;
                    return ListView.builder(
                      itemCount: episodes.length,
                      itemBuilder: (context, index) {
                        final episode = episodes[index];
                        final title = episode["title"];
                        final imageurl = episode["interestingMoment"]
                            ["_342x192"]["webp"]["value"]["url"];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  title,
                                  style: GoogleFonts.bebasNeue(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(imageurl),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(); // Placeholder or empty container
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchData() async {
    var url = Uri.parse('https://netflix-data.p.rapidapi.com/season/episodes/');
    var queryParams = {
      'ids': widget.episodeid.toString(),
      'offset': '0',
      'limit': '25',
    };
    var headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    var response = await http.get(
      url.replace(queryParameters: queryParams),
      headers: headers,
    );

    final json = jsonDecode(response.body);
    return json[0]["episodes"];
  }
}
