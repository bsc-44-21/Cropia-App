import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase.dart';

class AuthService {
  final SupabaseClient _client = SupabaseService.client;

  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name},
    );
    return response;
  }