import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class RoutesRepository {
  RoutesRepository._();

  static final RoutesRepository _instance = RoutesRepository._();

  factory RoutesRepository() => _instance;

  List<RouteModel>? _cachedRoutes;

  final supabase = Supabase.instance.client;

  Future<List<RouteModel>> getRoutes() async {
    final rawRoutes = await supabase.from('routes').select();
    _cachedRoutes ??= rawRoutes.map((e) => RouteModel.fromMap(e)).toList();

    return _cachedRoutes!;
  }

  Future<RouteModel> getRouteById(String id) async {
    final rawRoutes = await supabase.from('routes').select().eq('id', id);
    final foundRoute = rawRoutes.first;

    return RouteModel.fromMap(foundRoute);
  }
}
