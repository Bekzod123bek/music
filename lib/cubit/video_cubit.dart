import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/cubit/video_state.dart';

import '../model/video_model.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitialState()) {
    getVideos();
  }

  Future<void> getVideos() async {
    emit(VideoLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      final result = await rootBundle.loadString('assets/mock/mock_data.json');
      final Map<String, dynamic> data = json.decode(result);
      final VideoModel videoModel = VideoModel.fromJson(data);
      emit(VideoRightState(data: videoModel));
    } catch (e) {
      emit(VideoErrorState(errorText: 'Failed try again $e'));
    }
  }
}



// * exam -> cubit -> state, cubit

// * state xolat
// * cubit ->

// * mock-data -> video + connectivity_plus

// * bloc -> api -> firebase -> ads -> maps
