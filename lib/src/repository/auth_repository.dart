import 'dart:async';
import 'package:qaz_route_mobile/src/model/profile_model.dart';

class AuthRepository {
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return ProfileModel(
      id: 'usr_12345',
      name: 'Alex Johnson',
      email: 'alex.johnson@example.com',
      phoneNumber: '+1 (555) 123-4567',
      avatar: 'https://i.pravatar.cc/150?u=usr_12345',
      preferences: ['Hiking', 'Scenic Routes', 'Urban Exploration'],
      completedRoutes: 27,
      savedRoutes: 15,
      isPremium: true,
    );
  }
}
