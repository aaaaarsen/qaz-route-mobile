import 'package:auto_route/auto_route.dart';
import 'package:qaz_route_mobile/src/router/auth_guard.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:qaz_route_mobile/src/widget/auth_screen/auth_screen.dart';
import 'package:qaz_route_mobile/src/widget/home_screen/home_screen.dart';
import 'package:qaz_route_mobile/src/widget/map_screen/map_screen.dart';
import 'package:qaz_route_mobile/src/widget/profile_screen/profile_screen.dart';
import 'package:qaz_route_mobile/src/widget/qr_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, path: '/auth'),
    AutoRoute(
      page: AppRoute.page,
      path: '/',
      initial: true,
      guards: [AuthGuard()],
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: MapRoute.page, path: 'map'),
        AutoRoute(page: QrRoute.page, path: 'qr'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}
