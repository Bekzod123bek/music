import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/file_cubit.dart';
import '../cubit/file_state.dart';
import '../widgets/custom_audio_widget.dart';

class FilePickScreen extends StatefulWidget {
  const FilePickScreen({super.key});

  @override
  State<FilePickScreen> createState() => _FilePickScreenState();
}

class _FilePickScreenState extends State<FilePickScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FileCubit, FileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight),
                InkWell(
                  onTap: () {
                    context.read<FileCubit>().pickFile();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                        state is FileLoadingState
                            ? CircularProgressIndicator()
                            : Icon(Icons.download),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state is FileSuccessState) {
                      return CustomAudioWidget(
                        filePahth: state.audio.path,
                        musicName: state.musicName,
                        animationController: _animationController,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
