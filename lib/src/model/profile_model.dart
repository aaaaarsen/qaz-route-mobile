final class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String avatar;
  final List<String> preferences;
  final int completedRoutes;
  final int savedRoutes;
  final bool isPremium;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatar,
    required this.preferences,
    required this.completedRoutes,
    required this.savedRoutes,
    required this.isPremium,
  });
}
