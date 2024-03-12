import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/additionals/location.dart';
import 'package:my_app/utils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoModalContent extends StatefulWidget {
  final void Function(double position) togglePanel;
  final Location? currentLocation;

  const VideoModalContent({
    Key? key,
    required this.togglePanel,
    required this.currentLocation,
  }) : super(key: key);

  @override
  State<VideoModalContent> createState() => VideoModalContentState();
}

class VideoModalContentState extends State<VideoModalContent> {
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();

    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(
        widget.currentLocation!.video,
      ),
    );
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
                child: widget.currentLocation != null
                    ? Text(
                        widget.currentLocation!.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      )
                    : null,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FlickVideoPlayer(flickManager: _flickManager),
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
                onPressed: _closeModal,
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _closeModal() {
    _flickManager.dispose();
    GoRouter.of(context).pop();
    widget.togglePanel(1.0);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
