import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/colors.dart';

class MapPage extends ConsumerStatefulWidget {
  // final List<EventDetails> eventList;
  const MapPage({
    super.key,
    // required this.eventList,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> with OSMMixinObserver {
  late final MapController controller = MapController(
    initPosition: GeoPoint(latitude: 30.353539, longitude: 76.368524),
  );

  bool isRotated = false;
  @override
  void initState() {
    super.initState();
    // Future.delayed(
    //   Duration.zero,
    //   () => ref.read(eventMapPageProvider.notifier).init(widget.eventList),
    // );
    controller.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final locationData = ref.watch(
    //   eventsPageProvider.select(
    //     (_) => _.locationData,
    //   ),
    // );
    // final userData =
    //     ref.watch(appRepositoryProvider.select((value) => value.userData));
    // final eventData = ref.watch(
    //   eventMapPageProvider.select(
    //     (_) => _.eventList,
    //   ),
    // );
    return Scaffold(
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            onGeoPointClicked: (geoPoint) async {
              // final data = eventData
              //         ?.where((element) =>
              //             locationData
              //                 .firstWhere(
              //                     (e) => element.details.location == e.id)
              //                 .latitude ==
              //             geoPoint.latitude)
              //         .toList() ??
              //     [];
              // if (data.isNotEmpty) {
              //   ref.read(eventMapPageProvider.notifier).setGeoPoint(geoPoint);
              //   addCircularBorder(geoPoint, geoPoint.toString());
              // }
            },
            mapIsLoading: const Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )),
            osmOption: const OSMOption(
              roadConfiguration: const RoadOption(roadColor: primaryColor),
              enableRotationByGesture: false,
              userTrackingOption: const UserTrackingOption(
                enableTracking: true,
                unFollowUser: true,
              ),
              zoomOption: const ZoomOption(
                initZoom: 16,
                minZoomLevel: 16,
                maxZoomLevel: 18,
              ),
              staticPoints: [],
            ),
          ),
          // Positioned(
          //   right: 20,
          //   top: 30,
          //   child: GestureDetector(
          //     onTap: () async {
          //       if (isRotated) {
          //         await controller.rotateMapCamera(98);
          //         isRotated = false;
          //         setState(() {});
          //         return;
          //       }
          //       await controller.rotateMapCamera(278);
          //       isRotated = true;
          //       setState(() {});
          //     },
          //     child: Transform.rotate(
          //       angle: isRotated ? 40.9 : 0,
          //       child: Image.asset(
          //         'assets/images/ic_rotate.png',
          //         height: 40,
          //         width: 40,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   right: 70,
          //   top: 30,
          //   child: GestureDetector(
          //       onTap: () async {
          //         await controller.goToLocation(
          //             GeoPoint(latitude: 30.354347, longitude: 76.364076));
          //         //             await controller.setZoom(zoomLevel: 17);

          //         isRotated = false;
          //       },
          //       child: Container(
          //           decoration: const BoxDecoration(
          //             color: containerColor,
          //             shape: BoxShape.circle,
          //           ),
          //           child: const Padding(
          //             padding: EdgeInsets.all(6.0),
          //             child: Center(
          //                 child: Icon(
          //               Icons.location_on,
          //               color: secondaryColor,
          //             )),
          //           ))),
          // ),
          // Positioned(
          //   bottom: 20,
          //   left: MediaQuery.sizeOf(context).width / 2 - 30,
          //   child: EventMapBottomSheet(
          //       controller: controller, onChanged: addBorder),
          // ),
          // const Positioned(
          //   top: 30,
          //   left: 20,
          //   child: CustomBackButton(),
          // ),
        ],
      ),
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await controller.limitAreaMap(
        BoundingBox.fromGeoPoints(
          [
            GeoPoint(latitude: 30.362939, longitude: 76.358524),
            GeoPoint(latitude: 30.344411, longitude: 76.359321),
            GeoPoint(latitude: 30.352147, longitude: 76.373976),
            GeoPoint(latitude: 30.358610, longitude: 76.373263),
          ],
        ),
      );
      await controller
          .goToLocation(GeoPoint(latitude: 30.353539, longitude: 76.368524));
      addBorder();
      await controller.setZoom(zoomLevel: 18);

      await controller.rotateMapCamera(98);
    }
  }

  addCircularBorder(GeoPoint geoPoint, String locationId) async {
    await controller.removeAllCircle();
    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}1',
        centerPoint: geoPoint,
        radius: 60,
        color: Colors.pink,
        strokeWidth: 0,
      ),
    );
    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}2',
        centerPoint: geoPoint,
        radius: 40,
        color: Colors.pinkAccent,
        strokeWidth: 0,
      ),
    );

    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}5',
        centerPoint: geoPoint,
        radius: 40,
        color: Colors.pinkAccent,
        strokeWidth: 0,
      ),
    );
    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}3',
        centerPoint: geoPoint,
        radius: 10,
        color: Colors.white,
        strokeWidth: 0,
      ),
    );
    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}4',
        centerPoint: geoPoint,
        radius: 10,
        color: Colors.white,
        strokeWidth: 0,
      ),
    );
    await controller.drawCircle(
      CircleOSM(
        key: '${locationId}6',
        centerPoint: geoPoint,
        radius: 10,
        color: Colors.white,
        strokeWidth: 0,
      ),
    );

    await addBorder();
  }

  addBorder() async {
    await controller.drawRoad(
        GeoPoint(latitude: 30.350411, longitude: 76.359321),
        GeoPoint(latitude: 30.356539, longitude: 76.358524),
        roadOption: RoadOption(
          roadColor: Colors.black,
          roadWidth: Platform.isAndroid ? 20 : 10,
          zoomInto: false,
        ));

    await controller.drawRoad(
        GeoPoint(latitude: 30.350411, longitude: 76.359321),
        GeoPoint(latitude: 30.352147, longitude: 76.373976),
        roadOption: RoadOption(
          roadColor: Colors.black,
          roadWidth: Platform.isAndroid ? 20 : 10,
          zoomInto: false,
        ));
    await controller.drawRoad(
        GeoPoint(latitude: 30.352147, longitude: 76.373976),
        GeoPoint(latitude: 30.358610, longitude: 76.373263),
        roadOption: RoadOption(
          roadColor: Colors.black,
          roadWidth: Platform.isAndroid ? 20 : 10,
          zoomInto: false,
        ));

    await controller.drawRoad(
        GeoPoint(latitude: 30.356539, longitude: 76.358524),
        GeoPoint(latitude: 30.358610, longitude: 76.373263),
        roadOption: RoadOption(
          roadColor: Colors.black,
          roadWidth: Platform.isAndroid ? 20 : 10,
          zoomInto: false,
        ));
  }
}
