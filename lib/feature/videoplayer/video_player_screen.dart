import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String videoUrl;

  YouTubePlayerScreen({required this.videoUrl});

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        showLiveFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            bufferedColor: Colors.lightGreen,
            backgroundColor: Colors.grey,
          ),
          onReady: () {},
          onEnded: (data) {
            Navigator.pop(context);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
            ]);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 144),
        child: Container(
          height: 30,
          child: BottomAppBar(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]);
              },
              child: Text("Done",style: TextStyle(
    fontSize: 16,
    fontFamily: "Poppins",
    color: Colors.white,
    fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF61C3F2),
              ),
            ),
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
