import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://jotaufzxvsmggjtfilyh.supabase.co'; // e.g., 'https://your-project-ref.supabase.co'
  static const String supabaseAnonKey = 'sb_publishable_VHufc20fYU6ef0xdgt4DCA_46j5dlfU'; // The anon public key starting with 'eyJ...'

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}