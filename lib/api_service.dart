import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ganti sesuai URL Ngrok kamu yang aktif
  static const String baseUrl = 'https://navigate-constant-aflame.ngrok-free.dev/RagamNusa-API';

  // REGISTRASI USER BARU
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String role = 'renter', // 'renter' atau 'owner'
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone ?? '',
          'role': role,
        }),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server: $e'};
    }
  }

  // LOGIN USER
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return {'success': false, 'message': 'Gagal terhubung ke server: $e'};
    }
  }
}