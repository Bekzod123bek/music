import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomChewieVideoPlayer extends StatefulWidget {
  const CustomChewieVideoPlayer({super.key, required this.link});

  final String link;

  @override
  State<CustomChewieVideoPlayer> createState() =>
      _CustomChewieVideoPlayerState();
}

class _CustomChewieVideoPlayerState extends State<CustomChewieVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController; // * null ruxsat berdik

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.link),
    )..initialize().then((value) {});

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return [
          OptionItem(
            onTap: (v) {
              print('like bosildi');
            },
            iconData: Icons.favorite,
            title: 'Like',
          ),
        ];
      },
    );
  }

  // ! Dart -> xotirani controll (Garbage collector)
  // ! var, widget -> clear (controller)

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child:
              _chewieController == null &&
                      _videoPlayerController.value.isInitialized == false
                  ? CircularProgressIndicator()
                  : Chewie(controller: _chewieController!),
        ),
      ),
    );
  }
}
