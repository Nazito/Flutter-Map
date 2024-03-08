import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:my_app/additionals/location.dart';
import '../utils/constants.dart';

class FullInfoBlock extends StatefulWidget {
  final void Function(dynamic state) handleChangeCurrentLocation;
  final void Function() closePanel;
  final List<Location> locations;
  final Location? currentLocation;
  final String? experianceType;

  const FullInfoBlock({
    Key? key,
    required this.handleChangeCurrentLocation,
    required this.closePanel,
    required this.locations,
    required this.currentLocation,
    required this.experianceType,
  }) : super(key: key);

  @override
  FullInfoBlockState createState() => FullInfoBlockState();
}

class FullInfoBlockState extends State<FullInfoBlock> {
  late AudioPlayer player;
  bool isPlaying = false;
  bool isClosed = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    setupAudioPlayerListeners();
    if (widget.currentLocation != null) {
      player.play(widget.currentLocation!.audio);
    }
  }

  @override
  void didUpdateWidget(covariant FullInfoBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLocation != widget.currentLocation) {
      stopAndDisposePlayer();
      player = AudioPlayer();
      setupAudioPlayerListeners();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  void stopAndDisposePlayer() {
    player.stop();
    player.dispose();
  }

  void setupAudioPlayerListeners() {
    player.onPlayerStateChanged.listen((state) {
      safeSetState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      safeSetState(() {
        duration = newDuration;
      });
    });
    player.onPositionChanged.listen((newPosition) {
      safeSetState(() {
        position = newPosition;
      });
    });
    player.onPlayerComplete.listen((event) {
      if (widget.currentLocation != null &&
          widget.experianceType == "Virtual") {
        final currentIndex = widget.locations.indexOf(widget.currentLocation!);
        if (currentIndex < widget.locations.length - 1) {
          widget
              .handleChangeCurrentLocation(widget.locations[currentIndex + 1]);
          widget.closePanel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    safeSetState(() {
      position = position;
    });
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: widget.currentLocation != null
            ? Text(
                widget.currentLocation!.name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              )
            : null,
      ),
      Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            direction: Axis.horizontal,
            spacing: 30.0,
            children: (widget.currentLocation?.images ?? []).map((imagePath) {
              return Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          )),
      Container(
          margin: const EdgeInsets.only(bottom: 35),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: themeBgColor,
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
            // Make rounded corner of border
          ),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: widget.currentLocation != null
                  ? Text(
                      "Title",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    )
                  : null,
            ),

            // { < Audio Player
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                    height: 64.0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_arrow),
                                iconSize: 30.0,
                                padding: const EdgeInsets.all(15),
                                onPressed: () {
                                  widget.currentLocation != null
                                      ? isPlaying
                                          ? player.pause()
                                          : player.play(
                                              widget.currentLocation!.audio)
                                      : null;
                                },
                              )),
                          Expanded(
                              flex: 9,
                              child: Slider(
                                inactiveColor: themePrimaryColor,
                                thumbColor: themePrimaryColor,
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                autofocus: true,
                                onChanged: (value) async {
                                  final newPosition =
                                      Duration(seconds: value.toInt());
                                  setState(() {
                                    position = newPosition;
                                    if (isPlaying) {
                                      player.seek(position);
                                    }
                                  });
                                },
                              )),
                        ]))),
            //  Audio Player > }
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Expanded(
                    child: Column(children: [
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Interviewer(s)",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        right: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      )),
                      child: Column(
                        children: (widget.currentLocation?.interviewers ?? [])
                            .map((name) {
                          return SizedBox(
                            height: 64.0,
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                )),
                          );
                        }).toList(),
                      ))
                ])),
                Expanded(
                  child: Column(children: [
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Interviewee(s)",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        )),
                    Column(
                      children: (widget.currentLocation?.interviewees ?? [])
                          .map((name) {
                        String firstLetter = name.isNotEmpty ? name[0] : '';
                        String lastWord =
                            name.isNotEmpty ? name.split(' ').last : '';
                        String lastLetter =
                            lastWord.isNotEmpty ? lastWord[0] : '';
                        String concatenatedLetters = '$firstLetter$lastLetter';
                        return SizedBox(
                            height: 64.0,
                            width: 64.0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  child: Text(
                                    concatenatedLetters,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                            ));
                      }).toList(),
                    )
                  ]),
                ),
              ]),
            ),
          ])),
      Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: themeBgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  margin: const EdgeInsets.only(left: 150),
                  child: widget.currentLocation != null
                      ? Text(
                          widget.currentLocation!.descr,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        )
                      : null),
            )
          ]),
    ]);
  }
}
