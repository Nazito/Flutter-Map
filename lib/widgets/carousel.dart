import 'package:flutter/material.dart';
import 'package:my_app/additionals/location.dart';
import 'package:my_app/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  final void Function(dynamic state) handleCangeUserAcceptInfo;
  final void Function(dynamic state) handleChangeCurrentLocation;
  final String? experianceType;
  final List<Location> locations;

  const Carousel({
    Key? key,
    required this.handleCangeUserAcceptInfo,
    required this.handleChangeCurrentLocation,
    required this.experianceType,
    required this.locations,
  }) : super(key: key);

  @override
  CarouselState createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeOverlayColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.handleCangeUserAcceptInfo(true);
                    if (widget.experianceType == "Virtual") {
                      widget
                          .handleChangeCurrentLocation(widget.locations.first);
                    }
                  },
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  aspectRatio: 1.0,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _activeIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  Center(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Center(
                            child: Text(
                          'Use headphones for best experience',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ))),
                    const Icon(
                      Icons.headphones,
                      size: 65.0,
                    ),
                  ]))),
                  Center(
                      child: SingleChildScrollView(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                        Column(children: [
                          Text(
                            'Zoom out',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Icon(
                            Icons.open_in_full,
                            size: 65.0,
                          ),
                        ]),
                        Column(children: [
                          Text(
                            'Zoom in',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Icon(
                            Icons.close_fullscreen,
                            size: 65.0,
                          ),
                        ]),
                        Column(children: [
                          Text(
                            'Drag to move',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Icon(
                            Icons.start,
                            size: 65.0,
                          ),
                        ]),
                      ]))),
                  Center(
                      child: Text(
                    'Select the menu icon at the bottom left of your screen to return to view the menu at any time',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2].map((index) {
                  return Container(
                    width: 15.0,
                    height: 15.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _activeIndex == index
                          ? Colors.blueAccent
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
