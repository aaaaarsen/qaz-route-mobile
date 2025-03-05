import 'package:google_maps_flutter/google_maps_flutter.dart';

final class RouteModel {
  const RouteModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.path,
    required this.completionTime,
    required this.distance,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final int completionTime;
  final int distance;
  final List<LatLng> path;

  String formattedCompletionTime() {
    if (completionTime < 60) {
      return '$completionTime min';
    } else {
      final hours = completionTime ~/ 60;
      final mins = completionTime % 60;
      return mins > 0 ? '$hours h $mins min' : '$hours h';
    }
  }
}
