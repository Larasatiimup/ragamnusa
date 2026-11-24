import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ganti sesuai URL Ngrok kamu yang aktif
  static const String baseUrl = 'https://navigate-constant-aflame.ngrok-free.dev/RagamNusa-API';

  // Simpan token login di memori aplikasi
  static String? token;
  static Map<String, dynamic>? currentUser;

  // Header helper dengan token
  static Map<String, String> _headers({bool withAuth = true}) {
    final headers = {'Content-Type': 'application/json'};
    if (withAuth && token != null && token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ================= 1. AUTENTIKASI =================
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String role = 'renter',
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: _headers(withAuth: false),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone ?? '',
          'role': role,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: _headers(withAuth: false),
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(res.body);
      if (data['success'] == true) {
        token = data['tokens']['access_token'];
        currentUser = data['data'];
      }
      return data;
    } catch (e) {
      return {'success': false, 'message': 'Koneksi error: $e'};
    }
  }

  // ================= 2. KATALOG PRODUK =================
  // Ambil semua produk dari database
  static Future<List<dynamic>> getProducts({int? categoryId, String? search}) async {
    try {
      String url = '$baseUrl/products.php';
      List<String> params = [];
      if (categoryId != null) params.add('category_id=$categoryId');
      if (search != null && search.isNotEmpty) params.add('search=${Uri.encodeComponent(search)}');
      if (params.isNotEmpty) url += '?${params.join('&')}';

      final res = await http.get(Uri.parse(url), headers: _headers(withAuth: false));
      final data = jsonDecode(res.body);
      if (data['success'] == true && data['data'] != null) {
        return data['data'];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Ambil kategori budaya
  static Future<List<dynamic>> getCategories() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/categories.php'), headers: _headers(withAuth: false));
      final data = jsonDecode(res.body);
      if (data['success'] == true && data['data'] != null) {
        return data['data'];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ================= 3. PRODUK PEMILIK TOKO (OWNER) =================
  // Tambah produk baru oleh Pemilik Toko
  static Future<Map<String, dynamic>> addProduct({
    required String name,
    required int categoryId,
    required String description,
    required double pricePerDay,
    required double depositAmount,
    required int stock,
    required String conditionStatus, // 'new', 'good', 'fair'
    required String location,
    required String province,
    List<String>? photos,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/add_product.php'),
        headers: _headers(),
        body: jsonEncode({
          'name': name,
          'category_id': categoryId,
          'description': description,
          'price_per_day': pricePerDay,
          'deposit_amount': depositAmount,
          'stock': stock,
          'condition_status': conditionStatus,
          'location': location,
          'province': province,
          'photos': photos ?? [],
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal tambah produk: $e'};
    }
  }

  // ================= 4. PENYEWAAN / BOOKING =================
  // Buat sewa baru
  static Future<Map<String, dynamic>> createRental({
    required int productId,
    required int quantity,
    required String startDate, // YYYY-MM-DD
    required String endDate,   // YYYY-MM-DD
    required String shippingAddress,
    required String city,
    String? notes,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/create_rental.php'),
        headers: _headers(),
        body: jsonEncode({
          'start_date': startDate,
          'end_date': endDate,
          'shipping_address': shippingAddress,
          'city': city,
          'notes': notes ?? '',
          'items': [
            {'product_id': productId, 'quantity': quantity}
          ],
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal membuat sewa: $e'};
    }
  }

  // Ambil riwayat sewa saya (Penyewa)
  static Future<List<dynamic>> getMyRentals() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/my_rentals.php'), headers: _headers());
      final data = jsonDecode(res.body);
      if (data['success'] == true && data['data'] != null) {
        return data['data'];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ================= 5. PEMBAYARAN =================
  static Future<Map<String, dynamic>> createPayment({
    required int rentalId,
    required String paymentMethod, // 'qris', 'virtual_account', 'ewallet'
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/create_payment.php'),
        headers: _headers(),
        body: jsonEncode({
          'rental_id': rentalId,
          'payment_method': paymentMethod,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal proses pembayaran: $e'};
    }
  }

  // ================= 6. ULASAN / REVIEW =================
  static Future<Map<String, dynamic>> createReview({
    required int rentalId,
    required int productId,
    required int rating, // 1 - 5
    required String comment,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/create_review.php'),
        headers: _headers(),
        body: jsonEncode({
          'rental_id': rentalId,
          'product_id': productId,
          'rating': rating,
          'comment': comment,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Gagal simpan ulasan: $e'};
    }
  }
}