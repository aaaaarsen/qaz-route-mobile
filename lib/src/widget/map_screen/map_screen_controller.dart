import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';

enum MapScreenState { loading, idle, error }

class MapScreenController extends ChangeNotifier {
  MapScreenController({required this.repository});

  final RoutesRepository repository;

  List<RouteModel> _routes = [];

  List<RouteModel> get routes => _routes;

  MapScreenState _state = MapScreenState.idle;

  MapScreenState get state => _state;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  final Set<Polyline> _polylines = {};

  Set<Polyline> get polylines => _polylines;

  final Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  Future<void> loadRoutes() async {
    try {
      _state = MapScreenState.loading;
      notifyListeners();

      final routes = await repository.getRoutes();

      _routes = routes;
      _state = MapScreenState.idle;
    } catch (e) {
      _state = MapScreenState.error;
      _errorMessage = 'Failed to load routes: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  void loadPolylines() {
    for (var route in routes) {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route-${route.id}'),
          points: route.path,
          color: AppColors.info,
          width: 5,
        ),
      );
    }

    notifyListeners();
  }

  void loadMarkers() {
    for (var route in routes) {
      _markers.add(
        Marker(
          markerId: MarkerId("marker-${route.id}"),
          position: route.path.first,
          infoWindow: InfoWindow(title: route.title),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onTap: () {
            _polylines.clear();
            _polylines.add(
              Polyline(
                polylineId: PolylineId('route-${route.id}'),
                points: route.path,
                color: AppColors.info,
                width: 5,
              ),
            );

            notifyListeners();
          },
        ),
      );
    }

    notifyListeners();
  }
}
