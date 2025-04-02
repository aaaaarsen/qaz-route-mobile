import 'package:flutter/foundation.dart';
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

  RouteModel? _selectedRoute;

  RouteModel? get selectedRoute => _selectedRoute;

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

  void selectRoute(RouteModel route) {
    if (_selectedRoute?.id == route.id) {
      _selectedRoute = null;
      return;
    }

    _selectedRoute = route;

    notifyListeners();
  }
}
