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

  List<bool> genreSelections = List.filled(30, false);
  List<String> selectedGenres = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Image.asset(
            "assets/withoutbg.png",
            fit: BoxFit.fill,
            height: 100,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set the number of columns
              ),
              itemCount: netflixGenres.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          shape: const CircleBorder(),
                          value: genreSelections[index],
                          onChanged: (bool? value) {
                            setState(() {
                              genreSelections[index] = value!;
                              if (value!) {
                                selectedGenres.add(netflixGenres[index]);
                              } else {
                                selectedGenres.remove(netflixGenres[index]);
                              }
                            });
                          },
                          activeColor: Colors
                              .black, // Change the active color of the checkbox
                          checkColor: Colors.white,
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Reduce the size of the tap target
                        ),
                      ),
                      Text(
                        netflixGenres[index],
                        style: GoogleFonts.bebasNeue(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
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
              print(selectedGenres[0]);
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