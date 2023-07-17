import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/screens/homescreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/background.jpg",
                fit: BoxFit.cover,
              ),
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
            ],
          ),
          Positioned(
            height: 80,
            top: 200,
            left: 20,
            child: Image.asset(
              "assets/withoutbg.png",
              fit: BoxFit.fill,
            ),
          ),

          Positioned(
            top: 375,
            left: 20,
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: _emailEditingController,
                style: GoogleFonts.montserrat(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: GoogleFonts.montserrat(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),
          ),

          // for password
          Positioned(
            top: 450,
            left: 20,
            child: SizedBox(
              width: 350,
              child: TextField(
                controller: _passwordEditingController,
                style: GoogleFonts.montserrat(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: GoogleFonts.montserrat(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 520,
            left: 20,
            child: Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailEditingController.text,
                          password: _passwordEditingController.text)
                      .then((value) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(email: _emailEditingController.text)))
                          });
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
