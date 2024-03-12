import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:my_app/utils/constants.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(
        'assets/video/Intro_Video.mp4',
      ),
    );
    flickManager.flickVideoManager?.addListener(() {
      if (flickManager.flickVideoManager?.isVideoEnded ?? false) {
        GoRouter.of(context).go('/experience');
      }
    });
  }

  @override
  void dispose() {
    flickManager.flickVideoManager?.videoPlayerController?.pause();
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FlickVideoPlayer(flickManager: flickManager),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: themePrimaryColor,
                  ),
                ),
                onPressed: () {
                  flickManager.flickVideoManager?.videoPlayerController
                      ?.pause();
                  GoRouter.of(context).go('/experience');
                },
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
