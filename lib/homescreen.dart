import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/fetchdata.dart';
import 'package:netflix_clone/profile.dart';
import 'package:netflix_clone/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = '';
  late String choices;
  late List<String> listofchoices;
  @override
  void initState() {
    getStringFromSharedPreferences();
    // TODO: implement initState
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
              padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
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
                                  builder: (context) => Profile(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.all(6),
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
                          const Text(
                            "TV Shows",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Movies",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const Text(
                              "My List",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 50,
                          child: Container(
                            margin: EdgeInsets.symmetric(
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
                                icon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
                      Column(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          const Text(
                            "My List",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print(choices);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
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
                          const Text(
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
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: listofchoices.length,
            //       itemBuilder: ((context, index) {
            //         return DataWidget(text: listofchoices[index]);
            //       })),
            // ),

            DataWidget(text: "korean"),
            DataWidget(text: "hindi"),
            DataWidget(text: "anime"),
          ],
        ),
      ),
    );
  }

  Future<void> getStringFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    choices = prefs.getString("choices") ?? '';
    listofchoices = choices.split(";");
  }
}
