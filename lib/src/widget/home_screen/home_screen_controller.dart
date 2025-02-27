import 'package:flutter/foundation.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';

enum HomeScreenState { loading, idle, error }

class HomeScreenController extends ChangeNotifier {
  HomeScreenController({required this.repository});

  final RoutesRepository repository;

  HomeScreenState _state = HomeScreenState.idle;

  HomeScreenState get state => _state;

  List<RouteModel> _routes = [];

  List<RouteModel> get routes =>
      _routes.where((route) {
        return route.title.toLowerCase().contains(_searchQuery);
      }).toList();

  String _searchQuery = '';

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<void> loadRoutes() async {
    try {
      _state = HomeScreenState.loading;
      notifyListeners();

      final routes = await repository.getRoutes();

      _routes = routes;
      _state = HomeScreenState.idle;
    } catch (e) {
      _state = HomeScreenState.error;
      _errorMessage = 'Failed to load routes: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshRoutes() async {
    await loadRoutes();
  }

  void searchRoutes(String query) {
    final lowercaseQuery = query.toLowerCase();
    _searchQuery = lowercaseQuery;
    notifyListeners();
  }
}
