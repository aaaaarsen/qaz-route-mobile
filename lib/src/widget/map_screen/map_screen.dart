// import 'dart:async';
//
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:qaz_route_mobile/src/core/app_colors.dart';
// import 'package:qaz_route_mobile/src/model/route_model.dart';
// import 'package:qaz_route_mobile/src/repository/routes_repository.dart';
// import 'package:qaz_route_mobile/src/router/app_router.dart';
// import 'package:qaz_route_mobile/src/widget/map_screen/map_screen_controller.dart';
//
// @RoutePage()
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   late final MapScreenController _mapScreenController;
//
//   @override
//   void initState() {
//     super.initState();
//     _mapScreenController = MapScreenController(repository: RoutesRepository());
//     _mapScreenController.loadRoutes().whenComplete(() {
//       _mapScreenController.loadMarkers();
//     });
//   }
//
//   static const CameraPosition _kAlmaty = CameraPosition(
//     target: LatLng(43.23011246725963, 76.91868747847725),
//     zoom: 14,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.lightGreen600,
//         surfaceTintColor: AppColors.lightGreen600,
//         centerTitle: false,
//         title: Text(
//           'Map',
//           style: TextStyle(
//             color: AppColors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: ListenableBuilder(
//           listenable: _mapScreenController,
//           builder: (context, child) {
//             return Stack(
//               children: [
//                 Positioned.fill(
//                   child: GoogleMap(
//                     mapType: MapType.satellite,
//                     initialCameraPosition: _kAlmaty,
//                     polylines: _mapScreenController.polylines,
//                     markers: _mapScreenController.markers,
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller.complete(controller);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: MediaQuery.paddingOf(context).top,
//                   left: 0,
//                   right: 0,
//                   child: MapScreenRoutePreview(
//                     route: _mapScreenController.selectedRoute,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class MapScreenRoutePreview extends StatelessWidget {
//   const MapScreenRoutePreview({super.key, required this.route});
//
//   final RouteModel? route;
//
//   @override
//   Widget build(BuildContext context) {
//     if (route == null) {
//       return const SizedBox.shrink();
//     }
//
//     return InkWell(
//       onTap: () {
//         context.router.navigate(RouteDetailsRoute(route: route!));
//       },
//       child: Container(
//         margin: const EdgeInsets.all(16),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.2),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Image.network(
//                   route!.previewImageUrl,
//                   width: 64,
//                   height: 48,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         route!.title,
//                         style: const TextStyle(
//                           color: AppColors.neutral900,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         route!.location,
//                         style: TextStyle(
//                           color: AppColors.neutral900,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Distance', style: TextStyle(fontSize: 12)),
//                     const SizedBox(height: 2),
//                     Text(
//                       '${route!.distance} km',
//                       maxLines: 2,
//                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 48),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Duration', style: TextStyle(fontSize: 12)),
//                     const SizedBox(height: 2),
//                     Text(
//                       route!.formattedCompletionTime(),
//                       maxLines: 2,
//                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
