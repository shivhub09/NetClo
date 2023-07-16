import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late String titles;
  late String photourl;

  @override
  void initState() {
    fetchStringFromSharedPreferences();
    super.initState();
  }

  Future<void> fetchStringFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      titles = prefs.getString("wishtitle") ?? '';
      photourl = prefs.getString("wishphoto") ?? '';
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
                margin: EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(color: Colors.black),
                height: 90,
                child: Image.asset(
                  "assets/netflix logo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              titles,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
