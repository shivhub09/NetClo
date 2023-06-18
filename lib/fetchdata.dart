import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/apicall.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/details.dart';

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
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.red,
                          size: 50,
                        )
                      ],
                    ),
                  ),
                )
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              desc: description,
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
                              margin: EdgeInsets.all(8),
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
                  Center(
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
        'limit_titles': '10',
        'limit_suggestions': '10',
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
      isLoading = false;
    });
  }
}
