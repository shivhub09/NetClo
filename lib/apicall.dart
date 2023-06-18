import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isLoading = true;
  List<dynamic> users = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black),
                height: 70,
                child: Image.asset(
                  "assets/netflix logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : GridView.builder(
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
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
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
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
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

  void fetchData() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': 'netflix',
        'offset': '0',
        'limit_titles': '10',
        'limit_suggestions': '10',
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
      isLoading = false; // Set isLoading to false once data is fetched
      users = json["titles"];
    });
    print("loading");
    print(users);
  }
}
