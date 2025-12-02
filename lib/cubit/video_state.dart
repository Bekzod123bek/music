
import '../model/video_model.dart';

abstract class VideoState {}

final class VideoInitialState extends VideoState {}

final class VideoLoadingState extends VideoState {}

final class VideoErrorState extends VideoState {
  final String errorText;

  VideoErrorState({required this.errorText});
}

final class VideoRightState extends VideoState {
  final VideoModel data;

  VideoRightState({required this.data});
}
