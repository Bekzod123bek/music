import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    super.key,
    required this.videoLink,
    required this.videoName,
    required this.pageController,
    required this.isAutoSlide,
  });

  final String videoLink;
  final String videoName;
  final PageController pageController;
  final bool isAutoSlide;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController videoPlayerController;
  bool isVideoLoaded = false;
  bool istapped = false;
  late AnimationController _animationController;

  @override
  void initState() {
    // * aspectRatio - 16/9
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoLink),
      )
      ..initialize().then((_) {
        isVideoLoaded = true;
        videoPlayerController.play();
        print(
          'video player aspect ratio ${videoPlayerController.value.aspectRatio}',
        );
        setState(() {});
      });
    videoPlayerController.addListener(() {
      setState(() {});
      if (widget.isAutoSlide) {
        if (videoPlayerController.value.isCompleted) {
          widget.pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  String printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  double currentSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return isVideoLoaded == true
        ? Stack(
          children: [
            GestureDetector(
              onTap: () {
                istapped = true;
                setState(() {});
                print('video bovotmi ${videoPlayerController.value.isPlaying}');
                if (_animationController.status != AnimationStatus.forward) {
                  Future.delayed(Duration(seconds: 3)).then((v) {
                    istapped = false;
                    setState(() {});
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 250),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    VideoPlayer(videoPlayerController),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Slider(
                    //     min: 0.0,
                    //     max:
                    //         videoPlayerController.value.duration.inSeconds
                    //             .toDouble(),
                    //     value:
                    //         videoPlayerController.value.position.inSeconds
                    //             .toDouble(),
                    //     onChanged: (v) {},
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity:
                            videoPlayerController.value.isCompleted
                                ? 1.0
                                : istapped == true
                                ? 1.0
                                : 0.0,
                        child:
                            videoPlayerController.value.isCompleted
                                ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.black.withAlpha(100),
                                  child: IconButton(
                                    onPressed: () {
                                      videoPlayerController
                                          .seekTo(Duration(seconds: 0))
                                          .then((v) {
                                            videoPlayerController.play();
                                          });
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black.withAlpha(
                                        200,
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          final hozirgiVaxt =
                                              await videoPlayerController
                                                  .position;
                                          videoPlayerController.seekTo(
                                            Duration(
                                              seconds:
                                                  hozirgiVaxt!.inSeconds - 10,
                                            ),
                                          );
                                        },
                                        color: Colors.white,
                                        icon: Icon(Icons.skip_previous),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.black.withAlpha(
                                          200,
                                        ),
                                        child: IconButton(
                                          splashColor: Colors.transparent,
                                          onPressed: () {
                                            if (videoPlayerController
                                                .value
                                                .isPlaying) {
                                              _animationController.forward();
                                              videoPlayerController.pause();
                                            } else {
                                              _animationController.reverse();
                                              videoPlayerController.play();
                                            }
                                          },
                                          icon: AnimatedIcon(
                                            color: Colors.white,
                                            icon: AnimatedIcons.pause_play,
                                            progress: _animationController,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black.withAlpha(
                                        200,
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          final hozirgiVaxt =
                                              await videoPlayerController
                                                  .position;
                                          videoPlayerController.seekTo(
                                            Duration(
                                              seconds:
                                                  hozirgiVaxt!.inSeconds + 10,
                                            ),
                                          );
                                        },
                                        color: Colors.white,
                                        icon: Icon(Icons.skip_next),
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: currentSpeed,
                    items: [
                      DropdownMenuItem(value: 0.5, child: Text('0.5 x')),
                      DropdownMenuItem(value: 1.0, child: Text('1.0 x')),
                      DropdownMenuItem(value: 1.5, child: Text('1.5 x')),
                      DropdownMenuItem(value: 2.0, child: Text('2.0 x')),
                    ],
                    onChanged: (value) {
                      currentSpeed = value ?? 1.0;
                      videoPlayerController.setPlaybackSpeed(currentSpeed);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SafeArea(
                child: Builder(
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                printDuration(
                                  videoPlayerController.value.position,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                printDuration(
                                  videoPlayerController.value.duration,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 20,
                          child: Slider.adaptive(
                            activeColor: Colors.green,
                            inactiveColor: Colors.white,
                            min: 0.0,
                            max:
                                videoPlayerController.value.duration.inSeconds
                                    .toDouble(),
                            value:
                                videoPlayerController.value.position.inSeconds
                                    .toDouble(),
                            onChanged: (value) {
                              videoPlayerController.seekTo(
                                Duration(seconds: value.toInt()),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
        : Center(child: CupertinoActivityIndicator(color: Colors.white));
  }
}
