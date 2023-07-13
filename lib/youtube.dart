import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtubeplayer extends StatefulWidget {
  final String ytid;

  Youtubeplayer({required this.ytid});

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
        mute: true,
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
          body: player,
        );
      },
    );
  }
}
