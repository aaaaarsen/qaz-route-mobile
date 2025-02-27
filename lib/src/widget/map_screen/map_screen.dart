import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';
import 'package:qaz_route_mobile/src/widget/map_screen/map_screen_controller.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final MapScreenController _mapScreenController;

  @override
  void initState() {
    super.initState();
    _mapScreenController = MapScreenController(repository: RoutesRepository());
    _mapScreenController.loadRoutes().whenComplete(() {
      _mapScreenController.loadMarkers();
    });
  }

  static const CameraPosition _kAlmaty = CameraPosition(
    target: LatLng(43.23011246725963, 76.91868747847725),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: _mapScreenController,
        builder: (context, child) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kAlmaty,
            polylines: _mapScreenController.polylines,
            markers: _mapScreenController.markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
