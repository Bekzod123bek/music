import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitialState());

  Future<void> pickFile() async {
    emit(FileLoadingState());
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        print('Malumot keldi ${result.files}');
        emit(
          FileSuccessState(
            musicName: result.files.first.name,
            audio: File(result.files.first.path!),
          ),
        );
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(FileErrorState());
    }
  }
}
