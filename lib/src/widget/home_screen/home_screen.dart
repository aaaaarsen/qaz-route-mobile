import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/model/route_model.dart';
import 'package:qaz_route_mobile/src/repository/routes_repository.dart';
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
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        centerTitle: false,
        title: Text(
          'Discover Almaty',
          style: TextStyle(
            color: AppColors.neutral900,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: ListenableBuilder(
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
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.supplementary600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.supplementary600),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.supplementary600, width: 1.5),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 32,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final route = homeScreenController.routes[index];
              return _HomeScreenItem(route: route);
            }, childCount: homeScreenController.routes.length),
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
      child: CircularProgressIndicator(color: AppColors.supplementary600),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(route.imageUrl, fit: BoxFit.cover),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(route.title, maxLines: 1, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(route.location, maxLines: 2),
          ],
        ),
      ],
    );
  }
}
