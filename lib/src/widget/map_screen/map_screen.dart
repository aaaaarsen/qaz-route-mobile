import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';
import 'package:qaz_route_mobile/src/router/app_router.dart';
import 'package:qaz_route_mobile/src/widget/map_screen/map_screen_controller.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<MapboxMap> _mapboxMapCompleter = Completer<MapboxMap>();

  late final MapScreenController _mapScreenController;

  @override
  void initState() {
    super.initState();
    _mapScreenController = MapScreenController(repository: RoutesRepository());
    _mapScreenController.loadRoutes().whenComplete(() {
      _zoomToAlmaty();
      _loadMarkers();
    });
  }

  Future<void> _zoomToAlmaty() async {
    final mapboxMap = await _mapboxMapCompleter.future;

    mapboxMap.flyTo(_kAlmaty, MapAnimationOptions(duration: 3000));
  }

  Future<void> _loadMarkers() async {
    final mapboxMap = await _mapboxMapCompleter.future;

    final pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    final ByteData bytes = await rootBundle.load('assets/pin.png');
    final Uint8List markerBytes = bytes.buffer.asUint8List();

    for (var route in _mapScreenController.routes) {
      final PointAnnotationOptions annotationOptions = PointAnnotationOptions(
        geometry: route.path.first,
        image: markerBytes,
        iconSize: 1.2,
      );

      await pointAnnotationManager.create(annotationOptions);
    }

    pointAnnotationManager.addOnPointAnnotationClickListener(
      MarkerClickListener(
        onClick: (annotation) {
          final clickedRoute = _mapScreenController.routes.firstWhere((route) {
            final lat = route.path.first.coordinates.lat;
            final lng = route.path.first.coordinates.lng;
            final isSameLat = lat == annotation.geometry.coordinates.lat;
            final isSameLng = lng == annotation.geometry.coordinates.lng;
            return isSameLat && isSameLng;
          });
          _mapScreenController.selectRoute(clickedRoute);
        },
      ),
    );
  }

  Future<void> _zoomIn() async {
    final mapboxMap = await _mapboxMapCompleter.future;
    final currentCameraState = await mapboxMap.getCameraState();
    final currentZoom = currentCameraState.zoom;
    await mapboxMap.setCamera(CameraOptions(zoom: currentZoom + 1));
  }

  Future<void> _zoomOut() async {
    final mapboxMap = await _mapboxMapCompleter.future;
    final currentCameraState = await mapboxMap.getCameraState();
    final currentZoom = currentCameraState.zoom;
    await mapboxMap.setCamera(CameraOptions(zoom: currentZoom - 1));
  }

  static final CameraOptions _kAlmaty = CameraOptions(
    center: Point(coordinates: Position(76.91868747847725, 43.23011246725963)),
    zoom: 8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen600,
        surfaceTintColor: AppColors.lightGreen600,
        centerTitle: false,
        title: Text(
          'Map',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: MapWidget(
              onMapCreated: (MapboxMap mapboxMap) {
                _mapboxMapCompleter.complete(mapboxMap);
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ListenableBuilder(
              listenable: _mapScreenController,
              builder: (context, child) {
                return MapScreenRoutePreview(
                  route: _mapScreenController.selectedRoute,
                );
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom + 56,
            right: 8,
            child: FloatingActionButton.small(
              onPressed: _zoomIn,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              child: Icon(Icons.add, size: 24),
            ),
          ),
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom + 8,
            right: 8,
            child: FloatingActionButton.small(
              onPressed: _zoomOut,
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              child: Icon(Icons.remove, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkerClickListener extends OnPointAnnotationClickListener {
  final Function(PointAnnotation) onClick;

  MarkerClickListener({required this.onClick});

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onClick(annotation);
  }
}

class MapScreenRoutePreview extends StatelessWidget {
  const MapScreenRoutePreview({super.key, required this.route});

  final RouteModel? route;

  @override
  Widget build(BuildContext context) {
    if (route == null) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        context.router.navigate(RouteDetailsRoute(route: route!));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  route!.previewImageUrl,
                  width: 64,
                  height: 48,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        route!.title,
                        style: const TextStyle(
                          color: AppColors.neutral900,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        route!.location,
                        style: TextStyle(
                          color: AppColors.neutral900,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Distance', style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(
                      '${route!.distance} km',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 48),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Duration', style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(
                      route!.formattedCompletionTime(),
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
