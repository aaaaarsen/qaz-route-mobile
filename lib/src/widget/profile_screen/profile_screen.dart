import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';
import 'package:qaz_route_mobile/src/repository/auth_repository.dart';
import 'package:qaz_route_mobile/src/widget/profile_screen/profile_screen_controller.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileScreenController _profileScreenController;

  @override
  void initState() {
    super.initState();
    _profileScreenController = ProfileScreenController(
      repository: AuthRepository(),
    )..loadProfile();
  }

  @override
  void dispose() {
    _profileScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        centerTitle: false,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: _profileScreenController,
        builder: (context, child) {
          switch (_profileScreenController.state) {
            case ProfileScreenState.loading:
              return const _ProfileScreenLoading();
            case ProfileScreenState.error:
              return _ProfileScreenError(
                profileScreenController: _profileScreenController,
              );
            case ProfileScreenState.idle:
              return _ProfileScreenIdle(
                profileScreenController: _profileScreenController,
              );
          }
        },
      ),
    );
  }
}

class _ProfileScreenIdle extends StatelessWidget {
  const _ProfileScreenIdle({required this.profileScreenController});

  final ProfileScreenController profileScreenController;

  @override
  Widget build(BuildContext context) {
    final profile = profileScreenController.profile;

    if (profile == null) {
      return const Center(child: Text('No profile data available'));
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(profile.avatar),
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            profile.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profile.phoneNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileScreenLoading extends StatelessWidget {
  const _ProfileScreenLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.espresso),
    );
  }
}

class _ProfileScreenError extends StatelessWidget {
  const _ProfileScreenError({required this.profileScreenController});

  final ProfileScreenController profileScreenController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(profileScreenController.errorMessage),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: profileScreenController.refreshProfile,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
