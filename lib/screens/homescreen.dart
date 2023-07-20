import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/screens/tvshows.dart';
import 'package:netflix_clone/screens/wishlist.dart';
import 'package:netflix_clone/universal/fetchdata.dart';
import 'package:netflix_clone/profile.dart';
import 'package:netflix_clone/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = '';
  late String choices;
  late List<String> finalchoices;

  Future<void> fetchStringFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    choices = prefs.getString("choices") ?? '';
    final List<String> listofchoices = choices.split(";");
    setState(() {
      finalchoices = listofchoices;
    });
  }

  @override
  void initState() {
    fetchStringFromSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Profile(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                "assets/N.png",
                                fit: BoxFit.fill,
                                height: 20,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TvShows()));
                            },
                            child: const Text(
                              "TV Shows",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            "Movies",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Wishlist()));
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: const Text(
                                "My List",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white)),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                setState(() {
                                  _text = value;
                                  print(_text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Search(
                                        searchtext: _text,
                                      ),
                                    ),
                                  );
                                  Search(
                                    searchtext: _text,
                                  );
                                });
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.montserrat(
                                color: Colors.red,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorStyle: GoogleFonts.montserrat(),
                                hintText: 'Search',
                                hintStyle:
                                    GoogleFonts.montserrat(color: Colors.grey),
                                icon: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        children: [
                          Icon(
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
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                              ),
                              Text(
                                "Play",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Column(
                        children: [
                          Icon(
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
            DataWidget(text: "Popular on Netflix"),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: finalchoices.length,
              itemBuilder: (context, index) {
                return DataWidget(text: finalchoices[index]);
              },
            )
          ],
        ),
      ]),
    );
  }

  Future<List<String>> getStringFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    choices = prefs.getString("choices") ?? '';
    List<String> listofchoices = choices.split(";");
    return listofchoices;
  }
}
