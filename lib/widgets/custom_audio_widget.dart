import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomAudioWidget extends StatefulWidget {
  const CustomAudioWidget({
    super.key,
    required this.musicName,
    required this.filePahth,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final String musicName;
  final String filePahth;

  final AnimationController _animationController;

  @override
  State<CustomAudioWidget> createState() => _CustomAudioWidgetState();
}

class _CustomAudioWidgetState extends State<CustomAudioWidget> {
  late AudioPlayer _audioPlayer;
  Source? source; // * audio
  Duration hozirgivaxt = Duration(seconds: 0);
  Duration ummiyVaxt = Duration(seconds: 0);
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceDeviceFile(widget.filePahth).then((v) {
      source = _audioPlayer.source;
    });
    _audioPlayer.getDuration().then((value) {
      ummiyVaxt = value!;
      setState(() {});
    });
    _audioPlayer.onPositionChanged.listen((value) {
      hozirgivaxt = value;
      print('Umumiy voxt $hozirgivaxt');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(widget.musicName),
     // title: Slider(
     //    min: 0.0,
     //    max: ummiyVaxt.inSeconds.toDouble(),
     //    value: hozirgivaxt.inSeconds.toDouble(),
     //    onChanged: (value) {
     //      _audioPlayer.seek(Duration(seconds: value.toInt()));
     //      setState(() {});
     //    },
     //    padding: EdgeInsets.zero,
     //  ),
      leading: IconButton(
        onPressed: () {
          if (widget._animationController.status == AnimationStatus.completed) {
            _audioPlayer.pause();
            widget._animationController.reverse();
          } else {
            _audioPlayer.play(source!);
            widget._animationController.forward();
          }
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: widget._animationController,
        ),
      ),
    );
  }
}
