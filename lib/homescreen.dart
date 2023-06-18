import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/apicall.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<dynamic> users = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
              height: 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/wednesday.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/N.png",
                        fit: BoxFit.fill,
                        height: 30,
                      ),
                      Text(
                        "TV Shows",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        "Movies",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          "My List",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            "My List",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.play_arrow_rounded,
                              ),
                              const Text(
                                "Play",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          Text(
                            "Info",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                "Trending",
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 280, // Set a fixed height for the horizontal slider
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // Set scroll direction to horizontal
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final title = user['jawSummary']['title'];
                  final photo = user['jawSummary']['backgroundImage']['url'];
                  return Column(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': 'action',
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
      isLoading = false;
      users = json["titles"];
    });
    print("loading");
    print(users);
  }
}
