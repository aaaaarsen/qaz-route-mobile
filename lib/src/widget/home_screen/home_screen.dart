import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';
import 'package:qaz_route_mobile/src/router/app_router.dart';
import 'package:qaz_route_mobile/src/widget/home_screen/home_screen_controller.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenController _homeScreenController;

  @override
  void initState() {
    super.initState();
    _homeScreenController = HomeScreenController(repository: RoutesRepository())
      ..loadRoutes();
  }

  @override
  void dispose() {
    _homeScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen600,
        surfaceTintColor: AppColors.lightGreen600,
        centerTitle: false,
        title: Text(
          'Discover Almaty',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _homeScreenController,
          builder: (context, child) {
            switch (_homeScreenController.state) {
              case HomeScreenState.loading:
                return _HomeScreenLoading();
              case HomeScreenState.error:
                return _HomeScreenError(
                  homeScreenController: _homeScreenController,
                );
              case HomeScreenState.idle:
                return _HomeScreenIdle(
                  homeScreenController: _homeScreenController,
                );
            }
          },
        ),
      ),
    );
  }
}

class _HomeScreenIdle extends StatelessWidget {
  const _HomeScreenIdle({required this.homeScreenController});

  final HomeScreenController homeScreenController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: TextField(
              onChanged: (text) {
                homeScreenController.searchRoutes(text);
              },
              style: TextStyle(color: AppColors.neutral900),
              cursorColor: AppColors.supplementary600,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColors.neutral900),
                prefixIcon: Icon(Icons.search, color: AppColors.neutral900),
                fillColor: AppColors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.supplementary600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.supplementary600),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.supplementary600,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.separated(
            itemCount: homeScreenController.routes.length,
            itemBuilder: (context, index) {
              final route = homeScreenController.routes[index];
              return _HomeScreenItem(route: route);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
        ),
      ],
    );
  }
}

class _HomeScreenLoading extends StatelessWidget {
  const _HomeScreenLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.lightGreen600),
    );
  }
}

class _HomeScreenError extends StatelessWidget {
  const _HomeScreenError({required this.homeScreenController});

  final HomeScreenController homeScreenController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(homeScreenController.errorMessage),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: homeScreenController.refreshRoutes,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenItem extends StatelessWidget {
  const _HomeScreenItem({required this.route});

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.navigate(RouteDetailsRoute(route: route));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.hiking, size: 24),
                const SizedBox(width: 8),
                Text(
                  route.title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Distance', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(
                        '${route.distance} km',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Location', style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(
                        route.location,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Image.network(
                  route.previewImageUrl,
                  width: 128,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
