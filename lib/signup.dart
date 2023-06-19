import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/homescreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand, // Make the stack fit the whole screen
        children: [
          Image.asset(
            "assets/background.jpg",
            fit: BoxFit
                .cover, // Adjust the image's position and size to cover the entire stack
          ),
          Positioned(
            left: 0,
            top: 50,
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello!",
                    style:
                        GoogleFonts.bebasNeue(color: Colors.red, fontSize: 50),
                  ),
                  Text(
                    "TUDUM!!!",
                    style: GoogleFonts.bebasNeue(
                        color: Colors.white, fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: GestureDetector(
               onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                             
                            ),
                          ),
                        );
                      },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w100),
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
          ),
        ],
      ),
    );
  }
}
