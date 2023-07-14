import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtubeplayer extends StatefulWidget {
  final String ytid;
  final String title;
  final String desc;

  Youtubeplayer({required this.ytid, required this.title, required this.desc});

  @override
  State<Youtubeplayer> createState() => _YoutubeplayerState();
}

class _YoutubeplayerState extends State<Youtubeplayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.ytid,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        isLive: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.white,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                Container(
                  margin: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    widget.desc,
                    style: GoogleFonts.montserrat(
                        color: Colors.grey, fontSize: 18),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
