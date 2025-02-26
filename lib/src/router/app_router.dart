import 'package:auto_route/auto_route.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:qaz_route_mobile/src/widget/home_screen.dart';
import 'package:qaz_route_mobile/src/widget/maps_screen.dart';
import 'package:qaz_route_mobile/src/widget/profile_screen.dart';
import 'package:qaz_route_mobile/src/widget/qr_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AppRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: MapsRoute.page, path: 'maps'),
        AutoRoute(page: QrRoute.page, path: 'qr'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}
