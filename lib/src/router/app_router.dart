import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/router/auth_guard.dart';
import 'package:qaz_route_mobile/src/widget/app.dart';
import 'package:qaz_route_mobile/src/widget/auth_screen/auth_screen.dart';
import 'package:qaz_route_mobile/src/widget/home_screen/home_screen.dart';
import 'package:qaz_route_mobile/src/widget/home_screen/home_screen_wrapper.dart';
import 'package:qaz_route_mobile/src/widget/profile_screen/profile_screen.dart';
import 'package:qaz_route_mobile/src/widget/qr_screen/qr_screen.dart';
import 'package:qaz_route_mobile/src/widget/route_details_screen/route_details_screen.dart';

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
        AutoRoute(
          page: HomeRouteWrapper.page,
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
            AutoRoute(page: RouteDetailsRoute.page, path: 'details'),
          ],
        ),
        // AutoRoute(page: MapRoute.page, path: 'map'),
        AutoRoute(page: QrRoute.page, path: 'qr'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),
  ];
}

class HomeTab {}
