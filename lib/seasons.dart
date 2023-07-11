import 'package:flutter/material.dart';

class Seasons extends StatefulWidget {
  const Seasons({super.key});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: getseasons(),
            builder: ((context, snapshot) {
              return Text("hi");
            })),
      ),
    );
  }

  Future<void> getseasons() {
    return Future.delayed(const Duration(seconds: 2), () {});
  }
}
