import 'package:flutter/material.dart';

import '../screens/file_pick_screen.dart';
import '../screens/tiktok_screen.dart';
import '../widgets/custom_chewie_video_player.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Kelgan name ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => TiktokScreen());
      case '/detail':
        return MaterialPageRoute(builder: (context) => SizedBox());
      case '/chewie_screen':
        return MaterialPageRoute(
          builder:
              (context) => CustomChewieVideoPlayer(
                link:
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
              ),
        );
      case '/pick_file':
        return MaterialPageRoute(builder: (context) => FilePickScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Center(child: Text('No such kind of page')),
        );
    }
  }
}
