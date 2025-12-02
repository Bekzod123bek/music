import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/router/app_router.dart';

import 'cubit/file_cubit.dart';
import 'cubit/video_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VideoCubit()),
        BlocProvider(create: (context) => FileCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'Tik tok',
      initialRoute: "/pick_file",
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
