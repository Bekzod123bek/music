import 'dart:io';

abstract class FileState {}

class FileInitialState extends FileState {}

class FileErrorState extends FileState {}

class FileLoadingState extends FileState {}

class FileSuccessState extends FileState {
  File audio;
  String musicName;

  FileSuccessState({required this.audio, required this.musicName});
}
