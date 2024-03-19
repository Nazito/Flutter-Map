import 'package:flutter/material.dart';
import 'package:my_app/additionals/location.dart';
import 'package:my_app/additionals/locations_list.dart';
import 'package:my_app/main.dart';
import 'package:my_app/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class LocationsCarousel extends StatefulWidget {
  final void Function(double position) togglePanel;

  const LocationsCarousel({
    Key? key,
    required this.togglePanel,
  }) : super(key: key);

  @override
  CarouselState createState() => CarouselState();
}

class CarouselState extends State<LocationsCarousel> {
  final List<Location> locations = LocationList.locations;
  late AppState appStateRead;

  @override
  void initState() {
    super.initState();
    appStateRead = Provider.of<AppState>(context, listen: false);
  }

  _handleSelectLocation(Location locatin) {
    appStateRead.changeCurrentLocation(locatin);
  }

  // _onPageChanged(int idx, CarouselPageChangedReason bbb) {
  //   appStateRead.changeCurrentLocation(locations[idx]);
  //   _showVideoModal();
  // }

  // void _showVideoModal() {
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     builder: (BuildContext context) {
  //       return VideoModalContent(
  //           togglePanel: widget.togglePanel,
  //           currentLocation: Provider.of<AppState>(context).currentLocation);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100,
          viewportFraction: 0.7,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          // onPageChanged: _onPageChanged,
        ),
        items: locations.map((location) {
          AppState appStateWatch = Provider.of<AppState>(context);
          bool isSelected = appStateWatch.currentLocation?.id == location.id;

          return Material(
              color: isSelected ? Colors.red : themeSecondaryColor,
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () {
                  _handleSelectLocation(location);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: location.preview,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(
                              location.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
