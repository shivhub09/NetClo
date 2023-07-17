import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late String titles;
  late String photourl;
  List<String> listoftitle = [];
  List<String> listofurls = [];

  @override
  void initState() {
    fetchStringFromSharedPreferences();
    super.initState();
  }

  Future<void> fetchStringFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      titles = prefs.getString("wishlisttitles") ?? '';
      listoftitle = titles.split(";");
      photourl = prefs.getString("wishlistphotos") ?? '';
      listofurls = photourl.split(";");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: Colors.black),
                height: 90,
                child: Image.asset(
                  "assets/netflix logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                if (listoftitle.isEmpty)
                  Center(
                    child: Text(
                      "You do not have any items in the wish list",
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: listoftitle.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if (listofurls[index] != '')
                                SizedBox(
                                  height: 280,
                                  width: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      listofurls[index],
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          listoftitle[index],
                                          style: GoogleFonts.bebasNeue(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            delete(listoftitle[index],
                                                photourl[index]);
                                          },
                                          child: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<void> delete(String title, String photurl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String titles2 = prefs.getString("wishlisttitles") ?? '';
    String photourl2 = prefs.getString("wishlistphotos") ?? '';
    titles2.replaceAll(title + ";", '');
    photourl2.replaceAll(photourl2 + ";", '');
    print(titles2);
    print(photourl2);
  }
}
