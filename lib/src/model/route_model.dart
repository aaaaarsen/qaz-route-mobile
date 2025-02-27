import 'package:google_maps_flutter/google_maps_flutter.dart';

final class RouteModel {
  const RouteModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.path,
    required this.completionTime,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final int completionTime;
  final List<LatLng> path;
}
