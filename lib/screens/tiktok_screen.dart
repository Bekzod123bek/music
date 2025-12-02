import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../cubit/video_cubit.dart';
import '../cubit/video_state.dart';
import '../widgets/custom_video_player.dart';

class TiktokScreen extends StatefulWidget {
  const TiktokScreen({super.key});

  @override
  State<TiktokScreen> createState() => _TiktokScreenState();
}

class _TiktokScreenState extends State<TiktokScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();

  bool isAutoSlide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scafoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.settings, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.5,
        color: Colors.white,
        height: double.infinity,
        child: SwitchListTile.adaptive(
          title: Text('Auto next option'),
          value: isAutoSlide,
          onChanged: (v) {
            isAutoSlide = v;
            setState(() {});
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.grey,
              ),
            );
          } else if (state is VideoRightState) {
            return PageView.builder(
              controller: _pageController,
              itemCount: state.data.videos.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CustomVideoPlayer(
                  isAutoSlide: isAutoSlide,
                  pageController: _pageController,
                  videoName: state.data.videos[index].title,
                  videoLink: state.data.videos[index].sources.first,
                );
              },
            );
          } else if (state is VideoErrorState) {
            return Center(child: Text(state.errorText));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
