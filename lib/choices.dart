import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Choices extends StatefulWidget {
  const Choices({Key? key});

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  late String selectedGenresString;
  List<bool> genreSelections = List.filled(30, false);
  List<String> netflixGenres = [
    "Action & Adventure",
    "Anime",
    "Children & Family",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Fantasy",
    "Historical",
    "Horror",
    "LGBTQ+",
    "Music",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Sports",
    "Thriller",
    "Western",
    "Stand-Up Comedy",
    "Reality TV",
    "Psychological Thriller",
    "Superhero",
    "Teen",
    "War",
    "Independent",
    "Biographical",
    "Period Pieces",
    "Foreign Language",
    "Cult Films",
    "Classic Movies",
  ];

  List<String> selectedGenres = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Image.asset(
              "assets/withoutbg.png",
              fit: BoxFit.fill,
              height: 100,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: netflixGenres.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  child: CheckboxListTile(
                    value: genreSelections[index],
                    onChanged: (bool? newValue) {
                      setState(() {
                        genreSelections[index] = newValue ?? false;
                        if (genreSelections[index] == true) {
                          selectedGenres.add(netflixGenres[index]);
                        }

                        if (genreSelections[index] == false) {
                          if (selectedGenres.contains(netflixGenres[index])) {
                            selectedGenres.remove(netflixGenres[index]);
                          } else {
                            print(netflixGenres[index]);
                          }
                          ;
                        }
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    title: Text(
                      netflixGenres[index],
                      style: TextStyle(color: Colors.white),
                    ),
                    tristate: true,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              savedata();
              print(selectedGenresString);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void savedata() async {
    selectedGenresString = selectedGenres.join(';');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("choices", selectedGenresString);
  }
}
