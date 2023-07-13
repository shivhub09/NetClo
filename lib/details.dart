import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/apicall.dart';
import 'package:netflix_clone/privacy2.dart';
import 'package:netflix_clone/seasons.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/youtube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Details extends StatefulWidget {
  final String title;
  final String desc;
  final String backgroundimg;
  final String logoimgurl;
  final List<String> genres;
  final List<String> castlist;
  final int id;
  final String type;

  Details({
    required this.title,
    required this.desc,
    required this.backgroundimg,
    required this.logoimgurl,
    required this.genres,
    required this.castlist,
    required this.id,
    required this.type,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String youtubetitle = "";

  @override
  void initState() {
    // TODO: implement initState
    fetchdatayt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(widget.backgroundimg),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 10,
                  right: 10,
                  child: Image.network(widget.logoimgurl),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Youtubeplayer(ytid: '2RVnrBLOBcI'),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    Text(
                      "Play",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Text(
                widget.title,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.genres.length,
                itemBuilder: (context, index) {
                  final genreName = widget.genres[index];
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(
                                text: genreName,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(left: 0, right: 10),
                          child: Text(
                            genreName,
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 10,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.desc,
                style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Seasons",
                    style: GoogleFonts.bebasNeue(
                        color: Colors.white, fontSize: 30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Seasons(title: widget.title, id: widget.id),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Cast",
                style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 30),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.castlist.length,
                itemBuilder: (context, index) {
                  final castName = widget.castlist[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          castName,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey, fontSize: 18),
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
    );
  }

  void fetchdatayt() async {
    final url = Uri.https(
      'streamlinewatch-streaming-guide.p.rapidapi.com',
      '/search/',
      {
        'type': widget.type,
        'query': widget.title,
        'limit': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'streamlinewatch-streaming-guide.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);
    final body = response.body;
    final json = jsonDecode(body);

    final ytid = json[0]["_id"];

    final url2 = Uri.https(
      'streamlinewatch-streaming-guide.p.rapidapi.com',
      '/shows/${ytid}',
      {'platform': 'web', 'region': 'US'},
    );

    final response2 = await http.get(url2, headers: headers);
    final body2 = response2.body;
    final json2 = jsonDecode(body2);

    youtubetitle = json2[0]["youtube_trailer"];
  }
}
