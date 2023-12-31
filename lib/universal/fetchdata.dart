import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/universal/apicall.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/screens/details.dart';
import 'package:netflix_clone/privacy.dart';

class DataWidget extends StatefulWidget {
  final String text;
  DataWidget({required this.text});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  List<dynamic> users = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWidget(
                          text: widget.text,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "More",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.grey,
                            fontSize: 30,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.red,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 280, // Set a fixed height for the horizontal slider
            child: Stack(
              children: [
                ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Set scroll direction to horizontal
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final title = user['jawSummary']['title'];
                    final photo = user['jawSummary']['backgroundImage']['url'];
                    final description = user['jawSummary']['synopsis'];
                    final imageurl =
                        user['jawSummary']['backgroundImage']['url'];
                    final logoimgurl = user['jawSummary']['logoImage']['url'];
                    List<Map<String, dynamic>> genres =
                        (user['jawSummary']['genres'] as List<dynamic>)
                            .cast<Map<String, dynamic>>();
                    List<String> genrelist =
                        genres.map((item) => item["name"] as String).toList();
                    List<Map<String, dynamic>> castlist =
                        (user['jawSummary']['cast'] as List<dynamic>)
                            .cast<Map<String, dynamic>>();
                    List<String> cast =
                        castlist.map((item) => item["name"] as String).toList();
                    int id = user['summary']['id'];
                    final type = user["summary"]['type'];
                    return GestureDetector(
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
                              id: id,
                              type: type,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 200,
                              margin: const EdgeInsets.all(8),
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
                          Text(
                            title,
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ), // Circular loading indicator
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchdata() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': widget.text,
        'offset': '0',
        'limit_titles': '8',
        'limit_suggestions': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);
    final body = response.body;
    final json = jsonDecode(body);
    print(json);
    setState(() {
      users = json["titles"];
      isLoading = false;
    });
  }
}
