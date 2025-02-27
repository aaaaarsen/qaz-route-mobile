import 'package:flutter/foundation.dart';
import 'package:qaz_route_mobile/src/model/profile_model.dart';
import 'package:qaz_route_mobile/src/repository/auth_repository.dart';

enum ProfileScreenState { loading, idle, error }

class ProfileScreenController extends ChangeNotifier {
  ProfileScreenController({required this.repository});

  final AuthRepository repository;

  ProfileScreenState _state = ProfileScreenState.idle;

  ProfileScreenState get state => _state;

  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  Future<void> loadProfile() async {
    try {
      _state = ProfileScreenState.loading;
      notifyListeners();

      final profile = await repository.getProfile();
      _profile = profile;

      _state = ProfileScreenState.idle;
    } catch (e) {
      _state = ProfileScreenState.error;
      _errorMessage = 'Failed to load profile: ${e.toString()}';
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }
}
