import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = true;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _init();
  }

void _init() {
    _user = _authService.currentUser;
    _isLoading = false;
    notifyListeners();

    _authService.authStateChanges.listen((event) {
      _user = event.session?.user;
      _isLoading = false;
      notifyListeners();
    });
  }
  
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _authService.signUp(
      name: name,
      email: email,
      password: password,
    );
    // After successful sign up, automatically sign in
    await signIn(email: email, password: password);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authService.signIn(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}