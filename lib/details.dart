import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Details extends StatefulWidget {
  final String desc;
  final String backgroundimg;
  final String logoimgurl;
  Details(
      {required this.desc,
      required this.backgroundimg,
      required this.logoimgurl});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.backgroundimg),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(widget.logoimgurl),
                ),
              ],
            ),
            Text(
              widget.desc,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
