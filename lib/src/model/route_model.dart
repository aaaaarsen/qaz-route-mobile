import 'package:google_maps_flutter/google_maps_flutter.dart';

final class RouteModel {
  const RouteModel({
    required this.id,
    required this.previewImageUrl,
    required this.routeImagesUrls,
    required this.title,
    required this.location,
    required this.path,
    required this.completionTime,
    required this.distance,
    required this.description,
  });

  final String id;
  final String previewImageUrl;
  final List<String> routeImagesUrls;
  final String title;
  final String location;
  final int completionTime;
  final int distance;
  final List<LatLng> path;
  final String description;

  String formattedCompletionTime() {
    if (completionTime < 60) {
      return '$completionTime min';
    } else {
      final hours = completionTime ~/ 60;
      final mins = completionTime % 60;
      return mins > 0 ? '$hours h $mins min' : '$hours h';
    }
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'].toString(),
      previewImageUrl: map['preview_image_url'],
      routeImagesUrls: List<String>.from(map['route_images_urls']),
      title: map['title'],
      location: map['location'],
      completionTime: map['completion_time'],
      distance: map['distance'],
      path: List<LatLng>.from(
        (map['path'] as List).map((latLng) {
          final coords = latLng.split(',');
          return LatLng(double.parse(coords[0]), double.parse(coords[1]));
        }),
      ),
      description: map['description'],
    );
  }
}
