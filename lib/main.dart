import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const RagamNusaApp());

const kayu = Color(0xFF6B422D);
const gading = Color(0xFFF8F3E9);
const terracotta = Color(0xFFA66A43);
const zaitun = Color(0xFF78805B);
const teks = Color(0xFF302820);

const List<String> ragamNusaCategories = [
  'Pakaian Adat',
  'Alat Musik Tradisional',
  'Properti Event & Wedding',
  'Properti Kuliner',
  'Perlengkapan Workshop Kriya',
  'Transportasi Tradisional',
];

class RagamNusaApp extends StatelessWidget {
  const RagamNusaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'RAGAMNUSA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: gading,
          colorScheme: ColorScheme.fromSeed(seedColor: kayu, primary: kayu),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: kayu.withValues(alpha: .2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: terracotta, width: 1.5),
            ),
          ),
        ),
        home: const SplashPage(),
      );
}

void notice(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

// Data ulasan bersama untuk prototype: ulasan yang dikirim penyewa akan langsung muncul
// pada halaman Rating & Ulasan pemilik selama aplikasi masih berjalan.
final List<Map<String, dynamic>> ragamNusaReviews = [
  {'name': 'Sari Wulandari', 'product': 'Paket Busana Adat Bali', 'date': '18 Okt 2026', 'rating': 5, 'comment': 'Kebayanya cantik dan bersih. Detail bordirnya bagus, pemilik juga ramah dan responsif.', 'reply': 'Terima kasih sudah menyewa di toko kami! Senang sekali kebayanya cocok untuk acara Anda.'},
  {'name': 'Budi Santoso', 'product': 'Gamelan Mini', 'date': '16 Okt 2026', 'rating': 5, 'comment': 'Kain sesuai foto, proses sewa mudah dan pengiriman tepat waktu.', 'reply': ''},
  {'name': 'Rina Kartika', 'product': 'Paket Alat Membatik', 'date': '14 Okt 2026', 'rating': 4, 'comment': 'Barang bagus dan terawat. Akan lebih baik kalau pilihan warna ditambah.', 'reply': ''},
  {'name': 'Dewi Anggraini', 'product': 'Paket Busana Adat Bali', 'date': '11 Okt 2026', 'rating': 5, 'comment': 'Sangat puas! Ukuran pas dan barang dikemas dengan rapi.', 'reply': 'Terima kasih atas ulasannya, Kak Dewi. Kami tunggu pesanan berikutnya!'},
  {'name': 'Andi Pratama', 'product': 'Gamelan Mini', 'date': '8 Okt 2026', 'rating': 3, 'comment': 'Motifnya bagus, tetapi warna sedikit berbeda dari foto.', 'reply': ''},
];


// Data profil lokal untuk prototype. Nilai bertahan selama aplikasi berjalan,
// belum tersinkron ke server atau penyimpanan permanen.
final Map<String, String> renterProfileData = {
  'name': 'Sahabat Nusantara', 'phone': '', 'email': '', 'address': '',
  'city': '', 'notes': '',
};
final Map<String, String> ownerProfileData = {
  'name': 'Pemilik Budaya', 'phone': '', 'email': '', 'store': 'Toko Sari Budaya',
  'address': 'Yogyakarta, Indonesia', 'hours': 'Senin–Sabtu, 09.00–17.00',
  'description': 'Menyewakan busana dan perlengkapan budaya Indonesia yang terawat.',
  'rules': 'Gunakan barang dengan hati-hati. Pengembalian mengikuti tanggal pada pesanan. Kerusakan perlu didokumentasikan dan dibahas bersama.',
};
final Map<String, bool> renterPreferences = {
  'chat': true, 'delivery': true, 'pickup': false, 'reminder': true,
};

// Chat prototype bersama: percakapan terlihat dari sisi penyewa dan pemilik
// selama aplikasi berjalan. Untuk produksi, ganti penyimpanan lokal ini dengan backend.
final List<Map<String, dynamic>> ragamNusaChats = [
  {'id': 'chat-sari-kebaya', 'customer': 'Sari Wulandari', 'owner': 'Pemilik Budaya', 'product': 'Paket Busana Adat Bali', 'messages': <Map<String, String>>[
    {'sender': 'renter', 'text': 'Halo, apakah Kebaya Jawa tersedia untuk akhir pekan?','time':'09.12'},
    {'sender': 'owner', 'text': 'Halo Kak Sari, masih tersedia. Kakak butuh tanggal berapa?','time':'09.14'},
  ]},
  {'id': 'chat-budi-tenun', 'customer': 'Budi Santoso', 'owner': 'Pemilik Budaya', 'product': 'Gamelan Mini', 'messages': <Map<String, String>>[
    {'sender': 'renter', 'text': 'Apakah kain bisa diambil langsung?','time':'Kemarin'},
  ]},
];

Map<String, dynamic> getOrCreateRagamNusaChat(String product, {String customer = 'Sahabat Nusantara'}) {
  final found = ragamNusaChats.where((c) => c['product'] == product && c['customer'] == customer);
  if (found.isNotEmpty) return found.first;
  final thread = <String, dynamic>{
    'id': 'chat-${DateTime.now().microsecondsSinceEpoch}', 'customer': customer,
    'owner': 'Pemilik Budaya', 'product': product, 'messages': <Map<String, String>>[],
  };
  ragamNusaChats.insert(0, thread);
  return thread;
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool outline;
  const PrimaryButton(this.text, this.onTap, {super.key, this.outline = false});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 51,
        child: outline
            ? OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: kayu,
                  side: const BorderSide(color: kayu),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              )
            : FilledButton(
                onPressed: onTap,
                style: FilledButton.styleFrom(
                  backgroundColor: kayu,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
      );
}

class Brand extends StatelessWidget {
  final String heading;
  const Brand({super.key, this.heading = 'Marketplace Persewaan Produk Budaya Lokal'});
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: kayu, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.auto_awesome, color: gading, size: 27),
            ),
            const SizedBox(width: 12),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('RAGAMNUSA',
                  style: TextStyle(
                      color: kayu,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
              Text('Sewa budaya, hidupkan tradisi.',
                  style: TextStyle(color: teks, fontSize: 12)),
            ]),
          ]),
          const SizedBox(height: 27),
          Text(heading,
              style: const TextStyle(
                  color: teks, fontSize: 27, fontWeight: FontWeight.w900)),
        ],
      );
}


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF8F3E9), Color(0xFFE7DCCB)],
                  ),
                ),
              ),
            ),
            Positioned(right: -30, bottom: 15,
              child: Icon(Icons.spa_outlined, size: 220, color: terracotta.withValues(alpha: .16))),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 104, height: 104,
                      decoration: BoxDecoration(color: kayu, borderRadius: BorderRadius.circular(32)),
                      child: const Icon(Icons.spa_rounded, color: gading, size: 68),
                    ),
                    const SizedBox(height: 24),
                    const Text('RAGAMNUSA', textAlign: TextAlign.center,
                      style: TextStyle(color: kayu, fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                    const SizedBox(height: 8),
                    const Text('Sewa budaya, hidupkan tradisi.', textAlign: TextAlign.center,
                      style: TextStyle(color: teks, fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    const Text('Marketplace Persewaan Produk Budaya Lokal', textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF76685C), fontSize: 12)),
                    const SizedBox(height: 32),
                    const Icon(Icons.temple_hindu_outlined, color: terracotta, size: 88),
                    const SizedBox(height: 30),
                    PrimaryButton('Mulai', () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const LoginPage()))),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifikasi')),
    body: ListView(padding: const EdgeInsets.all(18), children: const [
      _NotificationTile(icon: Icons.receipt_long_outlined, title: 'Pesanan dikonfirmasi', detail: 'Status pesanan sewa akan muncul di sini.', time: 'Demo'),
      _NotificationTile(icon: Icons.calendar_month_outlined, title: 'Pengingat sewa', detail: 'Pengingat tanggal sewa akan muncul di sini.', time: 'Demo'),
      _NotificationTile(icon: Icons.chat_bubble_outline, title: 'Pesan baru', detail: 'Pesan dari pemilik toko akan muncul di sini.', time: 'Demo'),
    ]),
  );
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title, detail, time;
  const _NotificationTile({required this.icon, required this.title, required this.detail, required this.time});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: CircleAvatar(backgroundColor: const Color(0xFFF0DED0), child: Icon(icon, color: kayu)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text(detail)),
      trailing: Text(time, style: const TextStyle(fontSize: 10, color: terracotta)),
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool hide = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Brand(heading: 'Selamat datang kembali!'),
                    const SizedBox(height: 9),
                    Text('Masuk untuk melanjutkan perjalanan budaya kamu.',
                        style: TextStyle(color: teks.withValues(alpha: .7))),
                    const SizedBox(height: 25),
                    const Text('Email',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 7),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'nama@email.com',
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                    const SizedBox(height: 15),
                    const Text('Kata sandi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 7),
                    TextField(
                      controller: password,
                      obscureText: hide,
                      decoration: InputDecoration(
                        hintText: 'Masukkan kata sandi',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => hide = !hide),
                          icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())), child: const Text('Lupa kata sandi?'))),
                    const SizedBox(height: 8),
                    PrimaryButton('Masuk', () {
                      if (email.text.trim().isEmpty || password.text.isEmpty) {
                        notice(context, 'Email dan kata sandi wajib diisi.');
                      } else {
                        notice(context,
                            'Login demo saja. Autentikasi perlu dihubungkan ke backend.');
                      }
                    }),
                    const SizedBox(height: 12),
                    PrimaryButton('Daftar Akun', () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ChooseRolePage()));
                    }, outline: true),
                    const SizedBox(height: 20),
                    Center(
                      child: Text('Sewa budaya, hidupkan tradisi.',
                          style: TextStyle(color: teks.withValues(alpha: .65))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

enum Role { penyewa, pemilik }

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Daftar Akun')),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Brand(heading: 'Pilih role kamu'),
            const SizedBox(height: 9),
            Text('Pilih dulu peranmu. Setelah itu, isi formulir yang sesuai.',
                style: TextStyle(color: teks.withValues(alpha: .72), height: 1.5)),
            const SizedBox(height: 25),
            RoleOption(
              title: 'Penyewa',
              detail: 'Cari dan sewa perlengkapan budaya untuk acara atau kegiatanmu.',
              icon: Icons.person_search_outlined,
              color: zaitun,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterPage(role: Role.penyewa))),
            ),
            const SizedBox(height: 15),
            RoleOption(
              title: 'Pemilik Toko',
              detail: 'Daftarkan toko dan sewakan produk budaya milikmu.',
              icon: Icons.storefront_outlined,
              color: terracotta,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RegisterPage(role: Role.pemilik))),
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali ke Login'),
            ),
          ],
        ),
      );
}

class RoleOption extends StatelessWidget {
  final String title, detail;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const RoleOption({
    super.key,
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Container(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: color.withValues(alpha: .35)),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: .13),
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(detail, style: TextStyle(color: teks.withValues(alpha: .75), height: 1.4)),
                  const SizedBox(height: 10),
                  Text('Pilih role ini →',
                      style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                ]),
              ),
            ]),
          ),
        ),
      );
}

class RegisterPage extends StatefulWidget {
  final Role role;
  const RegisterPage({super.key, required this.role});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final identity = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  final shopName = TextEditingController();
  final shopAddress = TextEditingController();
  bool hidePassword = true;
  bool agree = false;

  bool get isOwner => widget.role == Role.pemilik;
  String? requiredField(String? value) =>
      value == null || value.trim().isEmpty ? 'Bagian ini wajib diisi.' : null;

  @override
  void dispose() {
    for (final c in [
      name, email, phone, identity, password, confirm, shopName, shopAddress
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Widget field(String label, TextEditingController controller,
      {String? hint, TextInputType keyboard = TextInputType.text,
      String? Function(String?)? validator, bool obscure = false,
      Widget? prefix, Widget? suffix, int lines = 1}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 7),
          TextFormField(
            controller: controller,
            keyboardType: keyboard,
            obscureText: obscure,
            maxLines: obscure ? 1 : lines,
            validator: validator ?? requiredField,
            decoration: InputDecoration(hintText: hint, prefixIcon: prefix, suffixIcon: suffix),
          ),
        ]),
      );

  void submit() {
    if (!formKey.currentState!.validate()) return;
    if (!agree) {
      notice(context, 'Centang persetujuan terlebih dahulu.');
      return;
    }
    final userName = name.text.trim();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => isOwner
            ? OwnerHomePage(ownerName: userName, shopName: shopName.text.trim())
            : RenterHomePage(userName: userName),
      ),
      (route) => route.isFirst,
    );
    notice(context, 'Pendaftaran demo berhasil. Data belum tersimpan ke database.');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Formulir ${isOwner ? "Pemilik Toko" : "Penyewa"}')),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (isOwner ? terracotta : zaitun).withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(children: [
                  Icon(isOwner ? Icons.storefront_outlined : Icons.person_outline,
                      color: isOwner ? terracotta : zaitun, size: 30),
                  const SizedBox(width: 12),
                  Expanded(child: Text(
                    isOwner
                        ? 'Daftar sebagai Pemilik Toko'
                        : 'Daftar sebagai Penyewa',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                  )),
                ]),
              ),
              const SizedBox(height: 22),
              const Text('DATA DIRI',
                  style: TextStyle(color: terracotta, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
              const SizedBox(height: 13),
              field(isOwner ? 'Nama pemilik' : 'Nama lengkap', name,
                  hint: 'Masukkan nama lengkap', prefix: const Icon(Icons.person_outline)),
              field('Email', email,
                  hint: 'nama@email.com',
                  keyboard: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email_outlined),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email wajib diisi.';
                    if (!v.contains('@') || !v.contains('.')) return 'Format email belum benar.';
                    return null;
                  }),
              field('Nomor telepon', phone,
                  hint: '08xxxxxxxxxx',
                  keyboard: TextInputType.phone,
                  prefix: const Icon(Icons.phone_outlined)),
              field('Nomor kartu identitas', identity,
                  hint: 'KTP/KIA/kartu identitas',
                  prefix: const Icon(Icons.badge_outlined)),
              Text(
                'Untuk percobaan, gunakan nomor contoh saja, bukan nomor identitas asli.',
                style: TextStyle(color: teks.withValues(alpha: .65), fontSize: 12),
              ),
              if (isOwner) ...[
                const SizedBox(height: 23),
                const Text('INFORMASI TOKO',
                    style: TextStyle(color: terracotta, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
                const SizedBox(height: 13),
                field('Nama toko', shopName,
                    hint: 'Contoh: Galeri Budaya Nusantara',
                    prefix: const Icon(Icons.store_outlined)),
                field('Alamat toko', shopAddress,
                    hint: 'Masukkan alamat toko',
                    prefix: const Icon(Icons.location_on_outlined), lines: 2),
              ],
              const SizedBox(height: 10),
              const Text('KEAMANAN AKUN',
                  style: TextStyle(color: terracotta, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
              const SizedBox(height: 13),
              field('Kata sandi', password,
                  hint: 'Minimal 8 karakter',
                  obscure: hidePassword,
                  prefix: const Icon(Icons.lock_outline),
                  suffix: IconButton(icon: Icon(hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => hidePassword = !hidePassword)),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Kata sandi wajib diisi.';
                    if (v.length < 8) return 'Minimal 8 karakter.';
                    return null;
                  }),
              field('Konfirmasi kata sandi', confirm,
                  hint: 'Ulangi kata sandi',
                  obscure: hidePassword,
                  prefix: const Icon(Icons.lock_reset_outlined),
                  suffix: IconButton(icon: Icon(hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => hidePassword = !hidePassword)),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Konfirmasi kata sandi wajib diisi.';
                    if (v != password.text) return 'Kata sandi belum sama.';
                    return null;
                  }),
              CheckboxListTile(
                value: agree,
                onChanged: (v) => setState(() => agree = v ?? false),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: kayu,
                title: const Text('Saya menyetujui ketentuan penggunaan RAGAMNUSA.',
                    style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(height: 12),
              PrimaryButton('Buat Akun', submit),
              const SizedBox(height: 10),
              PrimaryButton('Kembali pilih role', () => Navigator.pop(context), outline: true),
            ],
          ),
        ),
      );
}

class RenterHomePage extends StatefulWidget {
  final String userName;
  const RenterHomePage({super.key, required this.userName});
  @override
  State<RenterHomePage> createState() => _RenterHomePageState();
}

class _RenterHomePageState extends State<RenterHomePage> {
  int tab = 0;


  @override
  Widget build(BuildContext context) {
    final pages = [
      RenterDashboard(name: widget.userName, onExplore: () => setState(() => tab = 1)),
      const ExplorePage(),
      const OrdersPage(),
      RenterProfilePage(name: widget.userName),
    ];

    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(
        backgroundColor: gading,
        elevation: 0,
        title: const Text('RAGAMNUSA',
            style: TextStyle(color: kayu, fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          IconButton(
            tooltip: 'Chat dengan pemilik',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInboxPage(isOwner: false, currentCustomer: widget.userName))),
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: kayu),
          ),
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage())),
            icon: const Icon(Icons.notifications_none_rounded, color: kayu),
          ),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: gading,
        indicatorColor: terracotta.withValues(alpha: .15),
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Jelajah'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Pesanan'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class RenterDashboard extends StatelessWidget {
  final String name;
  final VoidCallback onExplore;
  const RenterDashboard({super.key, required this.name, required this.onExplore});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
    children: [
      Text('Halo, $name ', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 5),
      const Text('Temukan perlengkapan budaya untuk momen spesialmu.',
          style: TextStyle(color: Color(0xFF76685C), height: 1.4)),
      const SizedBox(height: 17),
      TextField(
        onSubmitted: (_) => onExplore(),
        onTap: onExplore,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Cari produk, kategori, atau toko...',
          prefixIcon: const Icon(Icons.search, color: kayu),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
      const SizedBox(height: 18),
      Container(
        height: 190,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF4E2F21), Color(0xFF8C583A), Color(0xFFA66A43)],
          ),
        ),
        child: Stack(children: [
          const Positioned(right: -7, bottom: -13,
            child: Icon(Icons.spa_outlined, size: 115, color: Color(0x44F8F3E9))),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('RAGAM BUDAYA\nDALAM SATU TEMPAT',
              style: TextStyle(color: gading, fontSize: 21, height: 1.2, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Sewa produk budaya dengan mudah\nuntuk acara dan kegiatanmu.',
              style: TextStyle(color: Color(0xFFF1E5D6), height: 1.4, fontSize: 12)),
            const Spacer(),
            FilledButton(
              onPressed: onExplore,
              style: FilledButton.styleFrom(backgroundColor: gading, foregroundColor: kayu),
              child: const Text('Jelajahi Produk  →'),
            ),
          ]),
        ]),
      ),
      const SizedBox(height: 24),
      _SectionTitle(title: 'Kategori Populer', action: 'Lihat semua', onTap: onExplore),
      const SizedBox(height: 12),
      GridView.count(
        crossAxisCount: 3, shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: .92,
        children: const [
          _CategoryTile('Pakaian\nAdat', Icons.checkroom_outlined),
          _CategoryTile('Alat Musik\nTradisional', Icons.music_note_outlined),
          _CategoryTile('Properti Event\n& Wedding', Icons.celebration_outlined),
          _CategoryTile('Properti\nKuliner', Icons.restaurant_outlined),
          _CategoryTile('Workshop\nKriya', Icons.brush_outlined),
          _CategoryTile('Transportasi\nTradisional', Icons.directions_bike_outlined),
        ],
      ),
      const SizedBox(height: 24),
      _SectionTitle(title: 'Produk Terbaru', action: 'Lihat semua', onTap: onExplore),
      const SizedBox(height: 12),
      SizedBox(
        height: 230,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            _ProductMiniCard(title: 'Paket Busana Adat Bali', category: 'Pakaian Adat', price: 'Rp150.000', location: 'Denpasar', imageUrl: 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Gamelan Mini', category: 'Alat Musik Tradisional', price: 'Rp250.000', location: 'Yogyakarta', imageUrl: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Gebyok Pelaminan Jawa', category: 'Properti Event & Wedding', price: 'Rp750.000', location: 'Surakarta', imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Set Alat Saji Tumpeng', category: 'Properti Kuliner', price: 'Rp100.000', location: 'Yogyakarta', imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Paket Alat Membatik', category: 'Perlengkapan Workshop Kriya', price: 'Rp125.000', location: 'Pekalongan', imageUrl: 'https://images.unsplash.com/photo-1452860606245-08befc0ff44b?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Andong Tradisional', category: 'Transportasi Tradisional', price: 'Rp500.000', location: 'Yogyakarta', imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=600'),
          ],
        ),
      ),
    ],
  );
}

class _SectionTitle extends StatelessWidget {
  final String title, action;
  final VoidCallback onTap;
  const _SectionTitle({required this.title, required this.action, required this.onTap});
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: teks))),
    TextButton(onPressed: onTap, child: Text(action, style: const TextStyle(color: terracotta, fontSize: 12))),
  ]);
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const _CategoryTile(this.title, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(14)),
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: kayu, size: 27),
      const SizedBox(height: 7),
      Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: teks, fontWeight: FontWeight.w700)),
    ]),
  );
}

class _ProductMiniCard extends StatelessWidget {
  final String title, category, price, location, imageUrl;
  const _ProductMiniCard({required this.title, required this.category, required this.price, required this.location, required this.imageUrl});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 158,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(title: title, category: category, price: price, location: location, imageUrl: imageUrl))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(imageUrl, height: 125, width: 158, fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(height: 125, color: const Color(0xFFE8D9C7), child: const Center(child: Icon(Icons.checkroom_outlined, size: 42, color: kayu)))),
        ),
        const SizedBox(height: 7),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, color: teks)),
        Text('$price/hari', style: const TextStyle(color: kayu, fontWeight: FontWeight.bold, fontSize: 12)),
        Row(children: [const Icon(Icons.location_on_outlined, size: 13, color: terracotta), Expanded(child: Text(location, style: const TextStyle(fontSize: 11, color: teks)))]),
      ]),
    ),
  );
}

class _CatalogItem {
  final String title, category, price, location, province, imageUrl;
  const _CatalogItem(this.title, this.category, this.price, this.location, this.province, this.imageUrl);
}

const List<_CatalogItem> _catalogItems = [
  _CatalogItem('Paket Busana Adat Bali', 'Pakaian Adat', '150000', 'Denpasar', 'Bali', 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=600'),
  _CatalogItem('Gamelan Mini', 'Alat Musik Tradisional', '250000', 'Yogyakarta', 'DI Yogyakarta', 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600'),
  _CatalogItem('Gebyok Pelaminan Jawa', 'Properti Event & Wedding', '750000', 'Surakarta', 'Jawa Tengah', 'https://images.unsplash.com/photo-1519741497674-611481863552?w=600'),
  _CatalogItem('Set Alat Saji Tumpeng Tradisional', 'Properti Kuliner', '100000', 'Yogyakarta', 'DI Yogyakarta', 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600'),
  _CatalogItem('Paket Alat Membatik', 'Perlengkapan Workshop Kriya', '125000', 'Pekalongan', 'Jawa Tengah', 'https://images.unsplash.com/photo-1452860606245-08befc0ff44b?w=600'),
  _CatalogItem('Andong Tradisional', 'Transportasi Tradisional', '500000', 'Yogyakarta', 'DI Yogyakarta', 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=600'),
];

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String category = 'Semua';
  String query = '';
  String province = 'Seluruh Indonesia';
  final categories = ['Semua', ...ragamNusaCategories];
  final provinces = const ['Seluruh Indonesia', 'Bali', 'DI Yogyakarta', 'Jawa Barat', 'Jawa Tengah', 'Jawa Timur', 'Kalimantan Barat', 'Kalimantan Selatan', 'Lampung', 'Nusa Tenggara Timur', 'Papua', 'Sulawesi Selatan', 'Sumatera Barat', 'Sumatera Selatan', 'Sumatera Utara'];
  @override
  Widget build(BuildContext context) {
    final shown = _catalogItems.where((p) =>
      (category == 'Semua' || p.category == category) &&
      (province == 'Seluruh Indonesia' || p.province == province) &&
      ('${p.title} ${p.category} ${p.location} ${p.province}'.toLowerCase().contains(query.toLowerCase()))).toList();
    return ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Jelajahi Budaya Nusantara', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 5),
      const Text('Temukan enam jenis persewaan produk budaya dari berbagai daerah Indonesia.', style: TextStyle(color: Color(0xFF78695D), height: 1.4)),
      const SizedBox(height: 14),
      TextField(onChanged: (v) => setState(() => query = v), decoration: InputDecoration(hintText: 'Cari produk, kategori, atau daerah...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(initialValue: province, decoration: const InputDecoration(labelText: 'Asal produk', prefixIcon: Icon(Icons.map_outlined)), items: provinces.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => province = v ?? province)),
      const SizedBox(height: 14),
      SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories.map((c) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(c),
              selected: category == c,
              selectedColor: const Color(0xFFE6D4C0),
              onSelected: (_) => setState(() => category = c),
            ),
          )).toList(),
        ),
      ),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(14)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.local_shipping_outlined, color: kayu), SizedBox(width: 10), Expanded(child: Text('Katalog lintas daerah Indonesia. Pengiriman antardaerah dapat dipilih sesuai jangkauan pemilik dan jasa ekspedisi; ketersediaan ongkir perlu dikonfirmasi sebelum transaksi.', style: TextStyle(color: teks, fontSize: 12, height: 1.4)))])),
      const SizedBox(height: 14),
      Row(children: [Expanded(child: Text('${shown.length} produk ditemukan', style: const TextStyle(fontWeight: FontWeight.w800, color: teks))), const Icon(Icons.grid_view_rounded, color: terracotta)]),
      const SizedBox(height: 10),
      if (shown.isEmpty) const Padding(padding: EdgeInsets.all(28), child: Center(child: Text('Produk tidak ditemukan. Coba ubah kata kunci atau filter.')))
      else GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: shown.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 14, childAspectRatio: .64), itemBuilder: (context, i) { final p = shown[i]; return _ExploreProduct(title: p.title, category: p.category, price: 'Rp${_rupiah(int.parse(p.price)).substring(2)}', location: p.location, imageUrl: p.imageUrl, province: p.province); }),
    ]);
  }
}

class _ExploreProduct extends StatelessWidget {
  final String title, category, price, location, imageUrl, province;

  const _ExploreProduct({
    required this.title,
    required this.category,
    required this.price,
    required this.location,
    required this.imageUrl,
    this.province = '',
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              title: title,
              category: category,
              price: price,
              location: location,
              imageUrl: imageUrl,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: const Color(0xFFE8D9C7),
                          child: const Center(
                            child: Icon(
                              Icons.festival_outlined,
                              size: 45,
                              color: kayu,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: gading.withValues(alpha: .95),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: kayu,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: teks,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$price/hari',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: kayu,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: terracotta,
                  ),
                  Expanded(
                    child: Text(
                      '$location${province.isNotEmpty ? ', $province' : ''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, color: teks),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              const Row(
                children: [
                  Icon(Icons.local_shipping_outlined, size: 13, color: zaitun),
                  SizedBox(width: 3),
                  Text(
                    'Tanya pengiriman',
                    style: TextStyle(
                      fontSize: 10,
                      color: zaitun,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _rentalCareForCategory(String category) {
  switch (category) {
    case 'Pakaian Adat':
      return 'Konfirmasi ukuran, kelengkapan aksesori, kebersihan/laundry, dan cara pengemasan agar pakaian tidak kusut atau rusak.';
    case 'Alat Musik Tradisional':
      return 'Periksa kelengkapan dan kondisi alat. Gunakan kotak atau bantalan pelindung; tanyakan apakah tersedia panduan penggunaan.';
    case 'Properti Event & Wedding':
      return 'Konfirmasi ukuran, akses lokasi, biaya angkut, tenaga pemasangan dan pembongkaran, serta jadwal persiapan acara.';
    case 'Properti Kuliner':
      return 'Konfirmasi bahan alat, jumlah komponen, kebersihan, keamanan kontak pangan, serta aturan pencucian dan pengembalian.';
    case 'Perlengkapan Workshop Kriya':
      return 'Periksa jumlah alat dan kelengkapannya. Tanyakan petunjuk penggunaan serta apakah bahan praktik termasuk atau dibeli terpisah.';
    case 'Transportasi Tradisional':
      return 'Konfirmasi kapasitas, area layanan, operator/pengemudi, kondisi kendaraan, akses lokasi, dan prosedur keselamatan sebelum pemesanan.';
    default:
      return 'Periksa kondisi, kelengkapan, aturan penggunaan, cara pengiriman, dan ketentuan pengembalian bersama pemilik.';
  }
}

class ProductDetailPage extends StatelessWidget {
  final String title, category, price, location, imageUrl;
  const ProductDetailPage({super.key, required this.title, required this.category, required this.price, required this.location, required this.imageUrl});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: gading,
    appBar: AppBar(backgroundColor: gading, title: const Text('Detail Produk')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(imageUrl, height: 280, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(height: 280, color: const Color(0xFFE8D9C7), child: const Icon(Icons.checkroom_outlined, size: 80, color: kayu)))),
      const SizedBox(height: 17),
      Text(title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: teks)),
      Text(category, style: const TextStyle(color: terracotta)),
      const SizedBox(height: 10),
      Text('$price / hari', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kayu)),
      const SizedBox(height: 8),
      Text('⌖  $location  ·  Tersedia untuk disewa', style: const TextStyle(color: teks)),
      const SizedBox(height: 18),
      const Text('Deskripsi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 6),
      const Text('Produk budaya pilihan untuk melengkapi acara, pentas seni, pemotretan, atau kegiatan spesialmu.', style: TextStyle(height: 1.5)),
      const SizedBox(height: 16),
      Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Informasi sebelum menyewa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: kayu)),
        const SizedBox(height: 8),
        Text(_rentalCareForCategory(category), style: const TextStyle(color: teks, height: 1.45)),
        const SizedBox(height: 8),
        const Text('Pengiriman, ongkir, kebutuhan pemasangan, dan ketersediaan akhir perlu dikonfirmasi dengan pemilik. Deposit mengikuti ketentuan produk dan dikembalikan setelah pemeriksaan barang.', style: TextStyle(color: teks, fontSize: 12, height: 1.4)),
      ])),
      const SizedBox(height: 22),
      PrimaryButton('Pilih Tanggal Sewa', () => Navigator.push(context, MaterialPageRoute(builder: (_) => RentalCalendarPage(title: title, price: price)))),
      const SizedBox(height: 10),
      PrimaryButton('Chat Pemilik', () { final thread = getOrCreateRagamNusaChat(title); Navigator.push(context, MaterialPageRoute(builder: (_) => ChatConversationPage(thread: thread, isOwner: false))); }, outline: true),
    ]),
  );
}

class RentalCalendarPage extends StatefulWidget {
  final String title, price;
  const RentalCalendarPage({super.key, required this.title, required this.price});
  @override
  State<RentalCalendarPage> createState() => _RentalCalendarPageState();
}

class _RentalCalendarPageState extends State<RentalCalendarPage> {
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: gading,
    appBar: AppBar(title: const Text('Ketersediaan Sewa'), backgroundColor: gading),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 6),
      const Text('Pilih tanggal mulai dan selesai sewa.'),
      const SizedBox(height: 20),
      _DatePickerTile(title: 'Tanggal mulai', date: startDate, onTap: () async {
        final d = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 1)), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)), builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: kayu, surface: gading)), child: child!));
        if (d != null) setState(() { startDate = d; if (endDate != null && !endDate!.isAfter(d)) endDate = null; });
      }),
      const SizedBox(height: 12),
      _DatePickerTile(title: 'Tanggal selesai', date: endDate, onTap: () async {
        final first = startDate ?? DateTime.now();
        final d = await showDatePicker(context: context, initialDate: first.add(const Duration(days: 1)), firstDate: first.add(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 365)), builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: kayu, surface: gading)), child: child!));
        if (d != null) setState(() => endDate = d);
      }),
      const SizedBox(height: 22),
      const Text('Catatan: ketersediaan ini masih demo dan belum terhubung ke database toko.', style: TextStyle(fontSize: 12, color: Color(0xFF78695D))),
      const SizedBox(height: 20),
      PrimaryButton('Lanjut ke Pembayaran', () {
        if (startDate == null || endDate == null) {
          notice(context, 'Pilih tanggal mulai dan selesai terlebih dahulu.');
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage(
            productTitle: widget.title,
            pricePerDay: _parsePrice(widget.price),
            startDate: startDate!,
            endDate: endDate!,
          )));
        }
      }),
    ]),
  );
}

class _DatePickerTile extends StatelessWidget {
  final String title;
  final DateTime? date;
  final VoidCallback onTap;
  const _DatePickerTile({required this.title, required this.date, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final value = date == null ? 'Pilih tanggal' : '${date!.day}/${date!.month}/${date!.year}';
    return ListTile(
      tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: Text(title), subtitle: Text(value), trailing: const Icon(Icons.calendar_month_outlined, color: kayu),
      onTap: onTap,
    );
  }
}


// AREA PEMILIK — pemetaan ERD utama:
// USERS (role pemilik), PRODUCTS + CATEGORIES, AVAILABILITY, RENTALS + ORDER_DETAILS,
// PAYMENTS, SHIPMENTS, CHATS + CHAT_MESSAGE, NOTIFICATIONS, VERIFICATIONS, DISPUTES, REFUNDS.
// Data saat ini dummy/local; repository/API dapat ditambahkan tanpa mengubah tema UI.
class OwnerHomePage extends StatefulWidget {
  final String ownerName, shopName;
  const OwnerHomePage({super.key, required this.ownerName, required this.shopName});
  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  int tab = 0;
  final List<Map<String, String>> products = [
    {'name': 'Paket Busana Adat Bali', 'category': 'Pakaian Adat', 'price': '150000', 'deposit': '100000', 'stock': '5', 'condition': 'Sangat baik', 'location': 'Denpasar', 'description': 'Paket busana adat Bali. Ukuran dan kelengkapan dikonfirmasi sebelum sewa.', 'status': 'Tersedia'},
    {'name': 'Gamelan Mini', 'category': 'Alat Musik Tradisional', 'price': '250000', 'deposit': '300000', 'stock': '2', 'condition': 'Baik', 'location': 'Yogyakarta', 'description': 'Set gamelan mini. Harap gunakan kemasan pelindung dan tangani instrumen dengan hati-hati.', 'status': 'Tersedia'},
    {'name': 'Gebyok Pelaminan Jawa', 'category': 'Properti Event & Wedding', 'price': '750000', 'deposit': '500000', 'stock': '1', 'condition': 'Baik', 'location': 'Surakarta', 'description': 'Properti dekorasi pelaminan. Biaya angkut, instalasi, dan bongkar dikonfirmasi terpisah.', 'status': 'Tersedia'},
    {'name': 'Set Alat Saji Tumpeng Tradisional', 'category': 'Properti Kuliner', 'price': '100000', 'deposit': '75000', 'stock': '4', 'condition': 'Sangat baik', 'location': 'Yogyakarta', 'description': 'Set alat saji tumpeng. Dikembalikan dalam keadaan bersih dan lengkap.', 'status': 'Tersedia'},
    {'name': 'Paket Alat Membatik', 'category': 'Perlengkapan Workshop Kriya', 'price': '125000', 'deposit': '100000', 'stock': '8', 'condition': 'Baik', 'location': 'Pekalongan', 'description': 'Paket alat membatik untuk kegiatan workshop. Bahan habis pakai dihitung terpisah.', 'status': 'Tersedia'},
    {'name': 'Andong Tradisional', 'category': 'Transportasi Tradisional', 'price': '500000', 'deposit': '500000', 'stock': '1', 'condition': 'Baik', 'location': 'Yogyakarta', 'description': 'Layanan andong dengan operator/pengemudi. Area layanan, kapasitas, dan jadwal wajib dikonfirmasi.', 'status': 'Tersedia'},
  ];
  final List<Map<String, String>> orders = [
    {'customer': 'Sari Wulandari', 'product': 'Paket Busana Adat Bali', 'date': '3–6 Okt 2026', 'total': '450000', 'status': 'Menunggu Konfirmasi'},
    {'customer': 'Budi Santoso', 'product': 'Gamelan Mini', 'date': '8–10 Okt 2026', 'total': '300000', 'status': 'Dikonfirmasi'},
    {'customer': 'Rina Kartika', 'product': 'Paket Alat Membatik', 'date': '12–14 Okt 2026', 'total': '225000', 'status': 'Sedang Disewa'},
  ];

  Future<void> editProduct(Map<String, String> product) async {
    final name = TextEditingController(text: product['name'] ?? '');
    final price = TextEditingController(text: _formatRibuan(product['price'] ?? ''));
    final stock = TextEditingController(text: product['stock'] ?? '1');
    final deposit = TextEditingController(text: _formatRibuan(product['deposit'] ?? '0'));
    final location = TextEditingController(text: product['location'] ?? '');
    final description = TextEditingController(text: product['description'] ?? '');
    String category = product['category'] ?? 'Pakaian Adat';
    String condition = product['condition'] ?? 'Sangat baik';
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(builder: (context, setDialogState) => AlertDialog(
        backgroundColor: gading,
        title: const Text('Edit Produk', style: TextStyle(color: kayu, fontWeight: FontWeight.w900)),
        content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama produk')),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(initialValue: category, decoration: const InputDecoration(labelText: 'Kategori'),
            items: ragamNusaCategories.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setDialogState(() => category = v ?? category)),
          const SizedBox(height: 10),
          TextField(controller: price, keyboardType: TextInputType.number, inputFormatters: [NominalRupiahInputFormatter()], decoration: const InputDecoration(labelText: 'Harga sewa per hari', prefixText: 'Rp ', helperText: 'Contoh: 20.000')),
          const SizedBox(height: 10),
          TextField(controller: stock, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok tersedia')),
          const SizedBox(height: 10),
          TextField(controller: deposit, keyboardType: TextInputType.number, inputFormatters: [NominalRupiahInputFormatter()], decoration: const InputDecoration(labelText: 'Deposit', prefixText: 'Rp ')),
          const SizedBox(height: 10),
          TextField(controller: location, decoration: const InputDecoration(labelText: 'Lokasi produk / toko')),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(initialValue: condition, decoration: const InputDecoration(labelText: 'Kondisi barang'),
            items: const ['Sangat baik', 'Baik', 'Cukup baik'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setDialogState(() => condition = v ?? condition)),
          const SizedBox(height: 10),
          TextField(controller: description, maxLines: 3, decoration: const InputDecoration(labelText: 'Deskripsi')),
        ])),
        actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: kayu), onPressed: () {
            final stockValue = int.tryParse(stock.text.trim());
            if (name.text.trim().isEmpty || _parseNominal(price.text) <= 0 || stockValue == null || stockValue < 0) {
              notice(dialogContext, 'Isi nama dan harga dengan benar. Stok harus 0 atau lebih.'); return;
            }
            Navigator.pop(dialogContext, {'name': name.text.trim(), 'category': category,
              'price': _parseNominal(price.text).toString(), 'stock': stockValue.toString(),
              'deposit': _parseNominal(deposit.text).toString(), 'condition': condition,
              'location': location.text.trim(), 'description': description.text.trim(),
              'status': stockValue == 0 ? 'Stok habis' : (product['status'] == 'Disembunyikan' ? 'Disembunyikan' : 'Tersedia')});
          }, child: const Text('Simpan perubahan'))],
      )),
    );
    if (result != null && mounted) { product
      ..clear()
      ..addAll(result); setState(() {}); }
    name.dispose(); price.dispose(); stock.dispose(); deposit.dispose(); location.dispose(); description.dispose();
  }


  void addProduct() async {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController(text: '1');
    final depositController = TextEditingController(text: '0');
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();
    String condition = 'Sangat baik';
    String category = 'Pakaian Adat';
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(builder: (context, setDialogState) =>
        AlertDialog(
          backgroundColor: gading,
          title: const Text('Tambah Produk', style: TextStyle(color: kayu, fontWeight: FontWeight.w900)),
          content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama produk')),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: category,
              decoration: const InputDecoration(labelText: 'Kategori'),
              items: ragamNusaCategories
                .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setDialogState(() => category = v ?? category),
            ),
            const SizedBox(height: 10),
            TextField(controller: priceController, keyboardType: TextInputType.number, inputFormatters: [NominalRupiahInputFormatter()], decoration: const InputDecoration(labelText: 'Harga sewa per hari', prefixText: 'Rp ', hintText: '20.000', helperText: 'Contoh: 20.000 atau 1.500.000')),
            const SizedBox(height: 10),
            TextField(controller: stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok')),
            const SizedBox(height: 10),
            TextField(controller: depositController, keyboardType: TextInputType.number, inputFormatters: [NominalRupiahInputFormatter()], decoration: const InputDecoration(labelText: 'Deposit (opsional)', prefixText: 'Rp ', hintText: '0', helperText: 'Boleh dikosongkan jika tanpa deposit')),
            const SizedBox(height: 10),
            TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Lokasi produk / toko')),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: condition,
              decoration: const InputDecoration(labelText: 'Kondisi barang'),
              items: const ['Sangat baik', 'Baik', 'Cukup baik']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setDialogState(() => condition = v ?? condition),
            ),
            const SizedBox(height: 10),
            TextField(controller: descriptionController, maxLines: 2, decoration: const InputDecoration(labelText: 'Deskripsi')),
          ])),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kayu),
              onPressed: () {
                if (nameController.text.trim().isEmpty || _parseNominal(priceController.text) <= 0 || (int.tryParse(stockController.text) ?? 0) <= 0) {
                  notice(dialogContext, 'Isi nama, harga, dan stok dengan benar.');
                  return;
                }
                Navigator.pop(dialogContext, {
                  'name': nameController.text.trim(), 'category': category,
                  'price': _parseNominal(priceController.text).toString(), 'stock': stockController.text.trim(),
                  'deposit': _parseNominal(depositController.text).toString(),
                  'condition': condition, 'location': locationController.text.trim(),
                  'description': descriptionController.text.trim(), 'status': 'Tersedia'
                });
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
    if (result != null && mounted) setState(() => products.insert(0, result));
    nameController.dispose(); priceController.dispose(); stockController.dispose();
    depositController.dispose(); locationController.dispose(); descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      OwnerDashboard(name: widget.ownerName, shop: widget.shopName, productCount: products.length, orders: orders,
        onOpenProducts: () => setState(() => tab = 1), onOpenOrders: () => setState(() => tab = 2),
        onOpenAvailability: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerAvailabilityPage(products: products))),
        onOpenReviews: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerReviewsPage(shopName: widget.shopName.isEmpty ? 'Toko Sari Budaya' : widget.shopName))),
        onOpenShopProfile: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerShopProfilePage(shopName: widget.shopName.isEmpty ? 'Toko Sari Budaya' : widget.shopName))),
        onOpenStats: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerPerformancePage())),
        onOpenVerification: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerVerificationPage()))),
      OwnerProductsPage(products: products, onAdd: addProduct, onEdit: editProduct, onChanged: () => setState(() {})),
      OwnerOrdersPage(orders: orders, onChanged: () => setState(() {})),
      const OwnerFinancePage(),
      OwnerProfilePage(name: widget.ownerName, shopName: widget.shopName),
    ];
    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(
        backgroundColor: gading, foregroundColor: kayu, elevation: 0,
        title: const Text('RAGAMNUSA', style: TextStyle(color: kayu, fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
          IconButton(
            tooltip: 'Chat dengan penyewa',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatInboxPage(isOwner: true))),
            icon: const Icon(Icons.chat_bubble_outline_rounded, color: kayu),
          ),
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage())),
            icon: const Icon(Icons.notifications_none_rounded, color: kayu),
          ),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      floatingActionButton: tab == 1 ? FloatingActionButton.extended(
        backgroundColor: kayu, foregroundColor: gading,
        onPressed: addProduct, icon: const Icon(Icons.add), label: const Text('Tambah produk'),
      ) : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: gading, indicatorColor: terracotta.withValues(alpha: .16),
        selectedIndex: tab, onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Produk'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Pesanan'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Keuangan'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class OwnerDashboard extends StatelessWidget {
  final String name, shop;
  final int productCount;
  final List<Map<String, String>> orders;
  final VoidCallback onOpenProducts, onOpenOrders, onOpenAvailability, onOpenReviews;
  final VoidCallback onOpenShopProfile, onOpenStats, onOpenVerification;
  const OwnerDashboard({super.key, required this.name, required this.shop, required this.productCount,
    required this.orders, required this.onOpenProducts, required this.onOpenOrders, required this.onOpenAvailability,
    required this.onOpenReviews, required this.onOpenShopProfile, required this.onOpenStats, required this.onOpenVerification});

  @override
  Widget build(BuildContext context) {
    final pending = orders.where((o) => o['status'] == 'Menunggu Konfirmasi').length;
    final reviewCount = ragamNusaReviews.length;
    final averageRating = reviewCount == 0
        ? 0.0
        : ragamNusaReviews.fold<int>(0, (sum, review) => sum + (review['rating'] as int)) / reviewCount;
    final unansweredReviews = ragamNusaReviews.where((review) => (review['reply'] as String? ?? '').trim().isEmpty).length;
    return ListView(padding: const EdgeInsets.fromLTRB(18, 8, 18, 24), children: [
      Text('Selamat datang, $name ', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 4),
      Text(shop.isEmpty ? 'Kelola toko budaya kamu di RAGAMNUSA.' : shop,
        style: TextStyle(color: teks.withValues(alpha: .7))),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF4E2F21), Color(0xFF8C583A), terracotta]),
        ),
        child: Stack(children: [
          const Positioned(right: 0, bottom: -10, child: Icon(Icons.spa_outlined, size: 90, color: Color(0x33F8F3E9))),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('TOKO BUDAYA ANDA', style: TextStyle(color: gading, fontSize: 12, letterSpacing: 1.3, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Jaga budaya,\nmajukan usaha.', style: TextStyle(color: gading, fontSize: 24, height: 1.2, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Pantau produk, pesanan, dan pendapatan dalam satu tempat.',
              style: TextStyle(color: Color(0xFFF1E5D6), height: 1.4)),
          ]),
        ]),
      ),
      const SizedBox(height: 22),
      const Text('Ringkasan toko', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: _OwnerMetric(icon: Icons.inventory_2_outlined, label: 'Produk aktif', value: '$productCount')),
        const SizedBox(width: 10),
        Expanded(child: _OwnerMetric(icon: Icons.receipt_long_outlined, label: 'Pesanan masuk', value: '${orders.length}')),
      ]),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: _OwnerMetric(icon: Icons.pending_actions_outlined, label: 'Perlu konfirmasi', value: '$pending')),
        const SizedBox(width: 10),
        const Expanded(child: _OwnerMetric(icon: Icons.account_balance_wallet_outlined, label: 'Pendapatan demo', value: 'Rp950 rb')),
      ]),
      const SizedBox(height: 22),
      _OwnerSectionHeader(title: 'Rating & komentar toko', action: 'Lihat semua', onTap: onOpenReviews),
      const SizedBox(height: 8),
      _surface(InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpenReviews,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
              width: 62, height: 62,
              decoration: BoxDecoration(color: const Color(0xFFF4E7D5), borderRadius: BorderRadius.circular(15)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(averageRating.toStringAsFixed(1), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: kayu)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (index) => Icon(index < averageRating.round() ? Icons.star_rounded : Icons.star_outline_rounded, size: 12, color: terracotta))),
              ]),
            ),
            const SizedBox(width: 13),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Ulasan dari penyewa', style: TextStyle(fontWeight: FontWeight.w900, color: teks)),
              const SizedBox(height: 4),
              const Text('Lihat komentar, penilaian, dan tanggapi ulasan pelanggan.', style: TextStyle(fontSize: 12, height: 1.35, color: Color(0xFF78695D))),
              const SizedBox(height: 6),
              Text('$reviewCount ulasan · $unansweredReviews belum dibalas', style: const TextStyle(fontSize: 11, color: terracotta, fontWeight: FontWeight.w800)),
            ])),
            const Icon(Icons.chevron_right, color: terracotta),
          ]),
        ),
      )),
      const SizedBox(height: 22),
      const Text('Kelola dan kembangkan toko', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 10),
      _surface(Column(children: [
        _OwnerActionTile(icon: Icons.storefront_outlined, title: 'Profil toko publik', subtitle: 'Foto sampul, alamat, jam operasional, dan informasi toko', onTap: onOpenShopProfile),
        const Divider(height: 1),
        _OwnerActionTile(icon: Icons.insights_outlined, title: 'Statistik performa', subtitle: 'Produk populer, pendapatan, dan tren penyewaan', onTap: onOpenStats),
        const Divider(height: 1),
        _OwnerActionTile(icon: Icons.verified_user_outlined, title: 'Verifikasi toko', subtitle: 'Status verifikasi identitas dan toko', onTap: onOpenVerification, trailing: const _VerificationPill()),
      ])),
      const SizedBox(height: 23),
      _OwnerSectionHeader(title: 'Pesanan terbaru', action: 'Lihat semua', onTap: onOpenOrders),
      const SizedBox(height: 8),
      ...orders.take(3).map((o) => _OwnerOrderTile(order: o, compact: true, onChanged: () {})),
      const SizedBox(height: 18),
      _OwnerSectionHeader(title: 'Kelola produk', action: 'Lihat produk', onTap: onOpenProducts),
      const SizedBox(height: 8),
      _surface(Row(children: [
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(13)),
          child: const Icon(Icons.storefront_outlined, color: kayu, size: 28)),
        const SizedBox(width: 12),
        const Expanded(child: Text('Pastikan harga, stok, dan ketersediaan produk selalu diperbarui.', style: TextStyle(height: 1.4))),
        const Icon(Icons.chevron_right, color: terracotta),
      ])),
      const SizedBox(height: 10),
      const SizedBox(height: 12),
      _surface(InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpenAvailability,
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Row(children: [
            CircleAvatar(backgroundColor: Color(0xFFEDE2D0), child: Icon(Icons.calendar_month_outlined, color: kayu)),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Kelola ketersediaan', style: TextStyle(fontWeight: FontWeight.w900, color: teks)),
              SizedBox(height: 3),
              Text('Atur tanggal produk bisa disewa atau sedang digunakan.', style: TextStyle(fontSize: 12, color: Color(0xFF78695D))),
            ])),
            Icon(Icons.chevron_right, color: terracotta),
          ]),
        ),
      )),
      const SizedBox(height: 12),
      const Text('Data pada dashboard ini masih berupa contoh untuk prototype.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
    ]);
  }
}

class _OwnerActionTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  const _OwnerActionTile({required this.icon, required this.title, required this.subtitle, required this.onTap, this.trailing});
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: kayu)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: teks, fontSize: 13)),
    subtitle: Padding(padding: const EdgeInsets.only(top: 3), child: Text(subtitle, style: const TextStyle(fontSize: 11, height: 1.3, color: Color(0xFF78695D)))),
    trailing: trailing ?? const Icon(Icons.chevron_right_rounded, color: terracotta),
  );
}

class _VerificationPill extends StatelessWidget {
  const _VerificationPill();
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFF5E9D8), borderRadius: BorderRadius.circular(20)), child: const Text('Demo', style: TextStyle(color: kayu, fontSize: 10, fontWeight: FontWeight.w800)));
}

class _OwnerMetric extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _OwnerMetric({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: kayu.withValues(alpha: .12))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: terracotta, size: 23),
      const SizedBox(height: 10),
      Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: kayu)),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(fontSize: 11, color: teks.withValues(alpha: .72))),
    ]),
  );
}

class _OwnerSectionHeader extends StatelessWidget {
  final String title, action;
  final VoidCallback onTap;
  const _OwnerSectionHeader({required this.title, required this.action, required this.onTap});
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: teks))),
    TextButton(onPressed: onTap, child: Text(action, style: const TextStyle(color: terracotta))),
  ]);
}

// Fitur ini merepresentasikan tabel AVAILABILITY pada ERD.
// Saat backend disambungkan, simpan product_id, start_date, end_date, status, create_at, updated_at.
class OwnerAvailabilityPage extends StatefulWidget {
  final List<Map<String, String>> products;
  const OwnerAvailabilityPage({super.key, required this.products});
  @override
  State<OwnerAvailabilityPage> createState() => _OwnerAvailabilityPageState();
}

class _OwnerAvailabilityPageState extends State<OwnerAvailabilityPage> {
  String? selectedProduct;
  final Map<String, Set<DateTime>> blockedDatesByProduct = {};

  DateTime _day(DateTime date) => DateTime(date.year, date.month, date.day);
  String _format(DateTime date) => '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  void initState() {
    super.initState();
    if (widget.products.isNotEmpty) selectedProduct = widget.products.first['name'];
  }

  Future<void> _addBlockedDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: kayu, surface: gading)),
        child: child!,
      ),
    );
    if (picked != null && mounted) {
      setState(() => blockedDatesByProduct.putIfAbsent(selectedProduct ?? '', () => <DateTime>{}).add(_day(picked)));
      notice(context, 'Tanggal ${_format(picked)} ditandai tidak tersedia (demo).');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedDates = (blockedDatesByProduct[selectedProduct ?? ''] ?? <DateTime>{}).toList()..sort();
    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(title: const Text('Ketersediaan Produk'), backgroundColor: gading, foregroundColor: kayu),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        const Text('Atur jadwal sewa', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: teks)),
        const SizedBox(height: 5),
        const Text('Tandai tanggal ketika produk sedang digunakan atau tidak dapat disewakan.', style: TextStyle(color: Color(0xFF78695D), height: 1.4)),
        const SizedBox(height: 18),
        DropdownButtonFormField<String>(
          initialValue: selectedProduct,
          decoration: const InputDecoration(labelText: 'Pilih produk', prefixIcon: Icon(Icons.inventory_2_outlined)),
          items: widget.products.map((p) => DropdownMenuItem(value: p['name'], child: Text(p['name'] ?? 'Produk'))).toList(),
          onChanged: (value) => setState(() => selectedProduct = value),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: kayu.withValues(alpha: .12))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [Icon(Icons.info_outline, color: terracotta), SizedBox(width: 8), Expanded(child: Text('Status ketersediaan', style: TextStyle(fontWeight: FontWeight.w900, color: teks)))]),
            const SizedBox(height: 12),
            const Row(children: [CircleAvatar(radius: 5, backgroundColor: zaitun), SizedBox(width: 8), Text('Tersedia untuk disewa')]),
            const SizedBox(height: 8),
            const Row(children: [CircleAvatar(radius: 5, backgroundColor: terracotta), SizedBox(width: 8), Text('Tidak tersedia / sedang digunakan')]),
            const SizedBox(height: 8),
            Text('Produk: ${selectedProduct ?? '-'}', style: const TextStyle(color: Color(0xFF78695D), fontSize: 12)),
          ]),
        ),
        const SizedBox(height: 16),
        PrimaryButton('Tandai tanggal tidak tersedia', _addBlockedDate),
        const SizedBox(height: 20),
        const Text('Tanggal yang diblokir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: teks)),
        const SizedBox(height: 10),
        if (sortedDates.isEmpty)
          _surface(const Padding(padding: EdgeInsets.all(18), child: Text('Belum ada tanggal yang diblokir.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF78695D)))))
        else
          ...sortedDates.map((date) => Container(
            margin: const EdgeInsets.only(bottom: 9),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFF0DED0), child: Icon(Icons.event_busy_outlined, color: terracotta)),
              title: Text(_format(date), style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(selectedProduct ?? 'Produk', style: const TextStyle(fontSize: 12)),
              trailing: IconButton(tooltip: 'Buka tanggal', icon: const Icon(Icons.close, color: kayu), onPressed: () => setState(() => blockedDatesByProduct[selectedProduct ?? '']?.remove(date))),
            ),
          )),
        const SizedBox(height: 8),
        const Text('Prototype: perubahan tanggal masih tersimpan sementara di aplikasi. Hubungkan ke tabel AVAILABILITY agar tersimpan di database.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D), height: 1.4)),
      ]),
    );
  }
}

class ChatInboxPage extends StatefulWidget {
  final bool isOwner;
  final String currentCustomer;
  const ChatInboxPage({super.key, required this.isOwner, this.currentCustomer = 'Sahabat Nusantara'});
  @override
  State<ChatInboxPage> createState() => _ChatInboxPageState();
}

class _ChatInboxPageState extends State<ChatInboxPage> {
  final searchController = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allThreads = widget.isOwner
        ? ragamNusaChats
        : ragamNusaChats.where((c) => c['customer'] == widget.currentCustomer || c['customer'] == 'Sahabat Nusantara').toList();
    final threads = allThreads.where((thread) {
      final person = widget.isOwner ? thread['customer'] as String : thread['owner'] as String;
      final product = thread['product'] as String;
      final lastMessages = thread['messages'] as List<Map<String, String>>;
      final last = lastMessages.isEmpty ? '' : (lastMessages.last['text'] ?? '');
      final query = searchText.toLowerCase();
      return person.toLowerCase().contains(query) || product.toLowerCase().contains(query) || last.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(
        backgroundColor: gading,
        foregroundColor: kayu,
        elevation: 0,
        titleSpacing: 20,
        title: const Text('Pesan', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: teks)),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.maybePop(context)),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            Text(
              widget.isOwner ? 'Percakapan penyewa' : 'Pesan kamu',
              style: const TextStyle(fontSize: 25, height: 1.2, fontWeight: FontWeight.w900, color: teks),
            ),
            const SizedBox(height: 6),
            Text(
              widget.isOwner
                  ? 'Balas pertanyaan dan koordinasikan detail penyewaan.'
                  : 'Tanyakan ketersediaan produk dan detail penyewaan kepada pemilik.',
              style: const TextStyle(fontSize: 14, height: 1.45, color: Color(0xFF78695D)),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: searchController,
              onChanged: (value) => setState(() => searchText = value),
              style: const TextStyle(fontSize: 14, color: teks),
              decoration: InputDecoration(
                hintText: 'Cari nama atau produk...',
                hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9A8D80)),
                prefixIcon: const Icon(Icons.search_rounded, color: terracotta),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: kayu.withValues(alpha: .10))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: terracotta, width: 1.3)),
              ),
            ),
            const SizedBox(height: 16),
            if (threads.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: kayu.withValues(alpha: .08))),
                child: Column(
                  children: [
                    Container(
                      width: 62, height: 62,
                      decoration: const BoxDecoration(color: Color(0xFFF2E7D8), shape: BoxShape.circle),
                      child: const Icon(Icons.forum_outlined, size: 29, color: terracotta),
                    ),
                    const SizedBox(height: 14),
                    Text(searchText.isEmpty ? 'Belum ada percakapan' : 'Percakapan tidak ditemukan',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: teks)),
                    const SizedBox(height: 6),
                    Text(
                      searchText.isNotEmpty
                          ? 'Coba kata kunci nama atau produk lain.'
                          : (widget.isOwner ? 'Pesan dari penyewa akan muncul di sini.' : 'Buka halaman produk, lalu pilih “Chat Pemilik” untuk memulai.'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, height: 1.45, color: Color(0xFF78695D)),
                    ),
                  ],
                ),
              )
            else
              ...threads.map((thread) {
                final messages = thread['messages'] as List<Map<String, String>>;
                final last = messages.isEmpty ? 'Mulai percakapan tentang produk ini' : (messages.last['text'] ?? '');
                final person = widget.isOwner ? thread['customer'] as String : thread['owner'] as String;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: kayu.withValues(alpha: .10)),
                    boxShadow: [BoxShadow(color: kayu.withValues(alpha: .035), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => ChatConversationPage(thread: thread, isOwner: widget.isOwner)));
                        if (mounted) setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(color: const Color(0xFFF0E4D4), borderRadius: BorderRadius.circular(16)),
                              child: Icon(widget.isOwner ? Icons.person_outline_rounded : Icons.storefront_outlined, color: kayu, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(person, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: teks)),
                                  const SizedBox(height: 3),
                                  Text(thread['product'] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: terracotta)),
                                  const SizedBox(height: 6),
                                  Text(last, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: Color(0xFF78695D))),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.chevron_right_rounded, color: terracotta, size: 23),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFEDE2D0).withValues(alpha: .72), borderRadius: BorderRadius.circular(13)),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline_rounded, size: 17, color: kayu),
                  SizedBox(width: 8),
                  Expanded(child: Text('Prototype: pesan masih tersimpan sementara di perangkat ini dan belum dikirim melalui internet.', style: TextStyle(fontSize: 11, height: 1.4, color: teks))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatConversationPage extends StatefulWidget {
  final Map<String, dynamic> thread;
  final bool isOwner;
  const ChatConversationPage({super.key, required this.thread, required this.isOwner});
  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  final inputFocusNode = FocusNode();
  List<String> get quickReplies => widget.isOwner
      ? const [
          'Halo Kak, stok masih tersedia ya ',
          'Boleh info tanggal sewanya?',
          'Untuk ukuran/detail, saya bantu cek ya.',
          'Silakan cek detail dan aturan sewanya ya.',
          'Terima kasih sudah menghubungi toko ',
        ]
      : const [
          'Halo Kak, stoknya masih ada?',
          'Bisa sewa untuk tanggal tertentu?',
          'Boleh tahu ukuran/kondisinya?',
          'Bagaimana cara pengambilannya?',
          'Terima kasih, Kak! ',
        ];
  @override
  void dispose() { controller.dispose(); scrollController.dispose(); inputFocusNode.dispose(); super.dispose(); }
  void send([String? preset]) {
    final text = (preset ?? controller.text).trim(); if (text.isEmpty) return;
    final messages = widget.thread['messages'] as List<Map<String, String>>;
    messages.add({'sender': widget.isOwner ? 'owner' : 'renter', 'text': text,
      'time': TimeOfDay.now().format(context)});
    controller.clear();
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      if (mounted) inputFocusNode.requestFocus();
    });
  }
  @override
  Widget build(BuildContext context) {
    final messages = widget.thread['messages'] as List<Map<String, String>>;
    final person = widget.isOwner ? widget.thread['customer'] as String : widget.thread['owner'] as String;
    return Scaffold(backgroundColor: gading, appBar: AppBar(backgroundColor: gading, foregroundColor: kayu, elevation: 0, title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(person, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: teks)), Text(widget.thread['product'] as String, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: terracotta))])),
      body: Column(children: [Container(width: double.infinity, padding: const EdgeInsets.all(10), color: const Color(0xFFEDE2D0), child: const Text('Diskusikan ketersediaan, ukuran, pengiriman, dan detail sewa dengan sopan.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: teks))),
        Expanded(child: ListView.builder(controller: scrollController, padding: const EdgeInsets.all(14), itemCount: messages.length, itemBuilder: (context, index) {
          final message = messages[index]; final mine = message['sender'] == (widget.isOwner ? 'owner' : 'renter');
          return Align(alignment: mine ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 9), padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10), constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .78), decoration: BoxDecoration(color: mine ? kayu : Colors.white, borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16), bottomLeft: Radius.circular(mine ? 16 : 4), bottomRight: Radius.circular(mine ? 4 : 16))), child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Align(alignment: Alignment.centerLeft, child: Text(message['text'] ?? '', style: TextStyle(color: mine ? Colors.white : teks, height: 1.35))), const SizedBox(height: 4), Text(message['time'] ?? '', style: TextStyle(color: mine ? Colors.white70 : Colors.black45, fontSize: 10))])));
        })),
        Container(
          width: double.infinity,
          color: gading,
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 2),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Pesan cepat · tekan untuk kirim', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: kayu)),
            const SizedBox(height: 7),
            SizedBox(height: 38, child: ListView(scrollDirection: Axis.horizontal, children: quickReplies.map((reply) => Padding(padding: const EdgeInsets.only(right: 7), child: ActionChip(label: Text(reply, style: const TextStyle(fontSize: 11)), backgroundColor: Colors.white, side: BorderSide(color: kayu.withValues(alpha: .15)), onPressed: () => send(reply)))).toList())),
          ]),
        ),
        SafeArea(top: false, child: Padding(padding: const EdgeInsets.fromLTRB(8, 5, 12, 10), child: Row(children: [
          Expanded(child: TextField(focusNode: inputFocusNode, controller: controller, minLines: 1, maxLines: 4, textInputAction: TextInputAction.send, onSubmitted: (_) => send(), decoration: InputDecoration(hintText: 'Tulis pesan...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
          const SizedBox(width: 6),
          IconButton.filled(onPressed: () => send(), style: IconButton.styleFrom(backgroundColor: kayu, foregroundColor: Colors.white), icon: const Icon(Icons.send_rounded)),
        ]))),
      ]));
  }
}

class OwnerProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final VoidCallback onAdd, onChanged;
  final Future<void> Function(Map<String, String>) onEdit;
  const OwnerProductsPage({super.key, required this.products, required this.onAdd, required this.onEdit, required this.onChanged});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(18, 10, 18, 90), children: [
    const Text('Produk Saya', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: teks)),
    const SizedBox(height: 5),
    const Text('Kelola katalog produk budaya yang kamu sewakan.', style: TextStyle(color: Color(0xFF78695D))),
    const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(14)),
      child: Row(children: [const Icon(Icons.info_outline, color: kayu), const SizedBox(width: 9),
        Expanded(child: Text('${products.length} produk terdaftar · Pastikan stok dan harga selalu akurat.', style: const TextStyle(color: teks, fontSize: 12)))])),
    const SizedBox(height: 14),
    ...products.map((p) => Container(
      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: kayu.withValues(alpha: .10))),
      child: Row(children: [
        Container(width: 64, height: 74, decoration: BoxDecoration(color: const Color(0xFFE8D9C7), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.checkroom_outlined, color: kayu, size: 30)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w900, color: teks)),
          const SizedBox(height: 3),
          Text(p['category'] ?? '', style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
          const SizedBox(height: 5),
          Text('${_rupiah(int.tryParse(p['price'] ?? '') ?? 0)}/hari', style: const TextStyle(fontWeight: FontWeight.bold, color: kayu)),
          Text('Stok ${p['stock']} · ${(int.tryParse(p['stock'] ?? '0') ?? 0) == 0 ? 'Stok habis' : (p['status'] ?? 'Tersedia')}', style: TextStyle(fontSize: 11, color: (int.tryParse(p['stock'] ?? '0') ?? 0) == 0 ? Colors.redAccent : zaitun)),
          if ((p['condition'] ?? '').isNotEmpty) Text('Kondisi: ${p['condition']}', style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
          if ((p['deposit'] ?? '0') != '0') Text('Deposit ${_rupiah(int.tryParse(p['deposit'] ?? '') ?? 0)}', style: const TextStyle(fontSize: 11, color: terracotta)),
          if ((p['location'] ?? '').isNotEmpty) Text(p['location']!, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
        ])),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: kayu),
          onSelected: (v) {
            if (v == 'edit') { onEdit(p); }
            if (v == 'toggle') { p['status'] = p['status'] == 'Tersedia' ? 'Disembunyikan' : 'Tersedia'; onChanged(); }
            if (v == 'delete') { products.remove(p); onChanged(); }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit nama, harga & stok')),
            PopupMenuItem(value: 'toggle', child: Text(p['status'] == 'Tersedia' ? 'Sembunyikan produk' : 'Tampilkan produk')),
            const PopupMenuItem(value: 'delete', child: Text('Hapus produk')),
          ],
        ),
      ]),
    )),
    OutlinedButton.icon(onPressed: onAdd, icon: const Icon(Icons.add, color: kayu), label: const Text('Tambah produk', style: TextStyle(color: kayu)),
      style: OutlinedButton.styleFrom(side: const BorderSide(color: kayu), padding: const EdgeInsets.all(14))),
  ]);
}

class OwnerOrdersPage extends StatelessWidget {
  final List<Map<String, String>> orders;
  final VoidCallback onChanged;
  const OwnerOrdersPage({super.key, required this.orders, required this.onChanged});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(18, 10, 18, 24), children: [
    const Text('Pesanan Masuk', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: teks)),
    const SizedBox(height: 5),
    const Text('Konfirmasi permintaan sewa dan pantau status pengembalian.', style: TextStyle(color: Color(0xFF78695D))),
    const SizedBox(height: 16),
    ...orders.map((o) => _OwnerOrderTile(order: o, onChanged: onChanged)),
    if (orders.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Text('Belum ada pesanan masuk.', textAlign: TextAlign.center)),
  ]);
}

class _OwnerOrderTile extends StatelessWidget {
  final Map<String, String> order;
  final bool compact;
  final VoidCallback onChanged;
  const _OwnerOrderTile({required this.order, this.compact = false, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final status = order['status'] ?? '';
    final pending = status == 'Menunggu Konfirmasi';
    final color = pending ? terracotta : status == 'Ditolak' ? Colors.red.shade700 : zaitun;
    return Container(
      margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: kayu.withValues(alpha: .10))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(backgroundColor: const Color(0xFFF0DED0), child: const Icon(Icons.person_outline, color: kayu)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(order['customer'] ?? '', style: const TextStyle(fontWeight: FontWeight.w900, color: teks)),
            Text(order['product'] ?? '', style: const TextStyle(fontSize: 12, color: Color(0xFF78695D))),
          ])),
          if (!compact) const Icon(Icons.chevron_right, color: terracotta),
        ]),
        const SizedBox(height: 10),
        Row(children: [const Icon(Icons.calendar_month_outlined, size: 15, color: terracotta), const SizedBox(width: 5), Text(order['date'] ?? '', style: const TextStyle(fontSize: 12))]),
        const SizedBox(height: 5),
        Row(children: [
          Expanded(child: Text(_rupiah(int.tryParse(order['total'] ?? '') ?? 0), style: const TextStyle(fontWeight: FontWeight.w900, color: kayu))),
          Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(20)),
            child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold))),
        ]),
        if (pending && !compact) ...[
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () { order['status'] = 'Ditolak'; onChanged(); notice(context, 'Pesanan ditolak (demo).'); },
              style: OutlinedButton.styleFrom(foregroundColor: kayu, side: const BorderSide(color: kayu)), child: const Text('Tolak'))),
            const SizedBox(width: 10),
            Expanded(child: FilledButton(onPressed: () { order['status'] = 'Dikonfirmasi'; onChanged(); notice(context, 'Pesanan dikonfirmasi (demo).'); },
              style: FilledButton.styleFrom(backgroundColor: kayu), child: const Text('Konfirmasi'))),
          ]),
        ],
      ]),
    );
  }
}

class OwnerReviewsPage extends StatefulWidget {
  final String shopName;
  const OwnerReviewsPage({super.key, required this.shopName});
  @override
  State<OwnerReviewsPage> createState() => _OwnerReviewsPageState();
}

class _OwnerReviewsPageState extends State<OwnerReviewsPage> {
  String filter = 'Semua';
  final List<Map<String, dynamic>> reviews = ragamNusaReviews;

  Future<void> _replyTo(Map<String, dynamic> review) async {
    final controller = TextEditingController(text: review['reply'] as String? ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: gading,
        title: const Text('Balas ulasan', style: TextStyle(color: kayu, fontWeight: FontWeight.w900)),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Ulasan dari ${review['name']}', style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(review['comment'] as String, style: const TextStyle(color: Color(0xFF78695D))),
          const SizedBox(height: 14),
          TextField(controller: controller, maxLines: 4, decoration: const InputDecoration(hintText: 'Tulis balasan yang sopan...')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, controller.text.trim()), style: FilledButton.styleFrom(backgroundColor: kayu), child: const Text('Simpan balasan')),
        ],
      ),
    );
    controller.dispose();
    if (result != null && result.isNotEmpty && mounted) {
      setState(() => review['reply'] = result);
      notice(context, 'Balasan tersimpan di prototype.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = reviews.where((r) => filter == 'Semua' || '${r['rating']} bintang' == filter).toList();
    final totalReviews = reviews.length;
    final average = totalReviews == 0 ? 0.0 : reviews.fold<int>(0, (sum, r) => sum + (r['rating'] as int)) / totalReviews;
    final unanswered = reviews.where((r) => (r['reply'] as String? ?? '').trim().isEmpty).length;
    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(backgroundColor: gading, foregroundColor: kayu, elevation: 0, title: const Text('Rating & Ulasan', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.fromLTRB(18, 8, 18, 28), children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4E2F21), Color(0xFFA66A43)]), borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Reputasi toko', style: TextStyle(color: gading, fontSize: 13)),
              const SizedBox(height: 5),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(average.toStringAsFixed(1), style: const TextStyle(color: gading, fontSize: 42, height: 1, fontWeight: FontWeight.w900)), const SizedBox(width: 7), const Padding(padding: EdgeInsets.only(bottom: 5), child: Text('/ 5.0', style: TextStyle(color: Color(0xFFF1E5D6))))]),
              const SizedBox(height: 7),
              Row(children: List.generate(5, (index) => Icon(index < average.round() ? Icons.star_rounded : Icons.star_outline_rounded, color: const Color(0xFFFFD27A), size: 18))),
              const SizedBox(height: 5),
              Text('Berdasarkan $totalReviews ulasan · $unanswered belum dibalas', style: const TextStyle(color: Color(0xFFF1E5D6), fontSize: 11)),
            ])),
            const Icon(Icons.reviews_outlined, color: Color(0x44F8F3E9), size: 82),
          ]),
        ),
        const SizedBox(height: 18),
        _surface(Column(children: [
          for (int stars = 5; stars >= 1; stars--) ...[
            if (stars != 5) const SizedBox(height: 10),
            _ratingBar(stars, reviews.where((review) => review['rating'] == stars).length,
              totalReviews == 0 ? '0%' : '${(reviews.where((review) => review['rating'] == stars).length * 100 / totalReviews).round()}%'),
          ],
        ])),
        const SizedBox(height: 22),
        const Text('Komentar penyewa', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900, color: teks)),
        const SizedBox(height: 10),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          for (final item in ['Semua', '5 bintang', '4 bintang', '3 bintang', '2 bintang', '1 bintang'])
            Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(item), selected: filter == item, selectedColor: const Color(0xFFE8D5C2), backgroundColor: Colors.white, labelStyle: TextStyle(color: filter == item ? kayu : teks, fontWeight: FontWeight.w700), side: BorderSide(color: kayu.withValues(alpha: .15)), onSelected: (_) => setState(() => filter = item))),
        ])),
        const SizedBox(height: 12),
        ...filtered.map((review) => _ReviewCard(review: review, onReply: () => _replyTo(review))),
        if (filtered.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Text('Belum ada ulasan pada kategori ini.', textAlign: TextAlign.center)),
        const SizedBox(height: 8),
        const Text('Ulasan awal adalah data contoh. Ulasan yang dikirim dari akun penyewa pada prototype ini akan tampil di sini selama aplikasi berjalan.', style: TextStyle(fontSize: 11, height: 1.4, color: Color(0xFF78695D))),
      ]),
    );
  }

  Widget _ratingBar(int stars, int count, String percent) => Row(children: [
    SizedBox(width: 54, child: Row(children: [Text('$stars', style: const TextStyle(fontWeight: FontWeight.w800)), const Icon(Icons.star_rounded, color: terracotta, size: 16)])),
    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: reviews.isEmpty ? 0 : count / reviews.length, minHeight: 8, backgroundColor: const Color(0xFFEDE2D0), color: terracotta))),
    const SizedBox(width: 10), SizedBox(width: 44, child: Text(percent, textAlign: TextAlign.end, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D)))),
  ]);
}

class _ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final VoidCallback onReply;
  const _ReviewCard({required this.review, required this.onReply});
  @override
  Widget build(BuildContext context) {
    final rating = review['rating'] as int;
    final reply = review['reply'] as String? ?? '';
    return Container(
      margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: kayu.withValues(alpha: .10))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(backgroundColor: const Color(0xFFEDE2D0), child: Text((review['name'] as String).substring(0, 1), style: const TextStyle(color: kayu, fontWeight: FontWeight.w900))),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(review['name'] as String, style: const TextStyle(fontWeight: FontWeight.w900, color: teks)),
            const SizedBox(height: 3),
            Text('${review['product']} · ${review['date']}', style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFF5E9D8), borderRadius: BorderRadius.circular(10)), child: Row(children: [Text('$rating.0', style: const TextStyle(color: kayu, fontWeight: FontWeight.w900, fontSize: 12)), const SizedBox(width: 3), const Icon(Icons.star_rounded, size: 14, color: terracotta)])),
        ]),
        const SizedBox(height: 11),
        Row(children: List.generate(5, (i) => Icon(i < rating ? Icons.star_rounded : Icons.star_outline_rounded, size: 17, color: terracotta))),
        const SizedBox(height: 7),
        Text(review['comment'] as String, style: const TextStyle(height: 1.45, color: teks)),
        if (reply.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF8F3E9), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Balasan toko', style: TextStyle(color: kayu, fontWeight: FontWeight.w900, fontSize: 12)), const SizedBox(height: 4), Text(reply, style: const TextStyle(fontSize: 12, height: 1.4, color: teks))])),
        ],
        const SizedBox(height: 8),
        Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: onReply, icon: const Icon(Icons.reply_rounded, size: 17), label: Text(reply.isEmpty ? 'Balas ulasan' : 'Edit balasan'), style: TextButton.styleFrom(foregroundColor: kayu))),
      ]),
    );
  }
}

class OwnerShopProfilePage extends StatefulWidget {
  final String shopName;
  const OwnerShopProfilePage({super.key, required this.shopName});
  @override
  State<OwnerShopProfilePage> createState() => _OwnerShopProfilePageState();
}

class _OwnerShopProfilePageState extends State<OwnerShopProfilePage> {
  late final TextEditingController nameController = TextEditingController(text: ownerProfileData['store'] == 'Toko Sari Budaya' ? widget.shopName : ownerProfileData['store']);
  final addressController = TextEditingController(text: ownerProfileData['address']);
  final hoursController = TextEditingController(text: ownerProfileData['hours']);
  final descriptionController = TextEditingController(text: ownerProfileData['description']);
  @override
  void dispose() { nameController.dispose(); addressController.dispose(); hoursController.dispose(); descriptionController.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: gading,
    appBar: AppBar(backgroundColor: gading, foregroundColor: kayu, elevation: 0, title: const Text('Profil Toko Publik', style: TextStyle(fontWeight: FontWeight.w900))),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(height: 145, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF4E2F21), Color(0xFFA66A43)])), child: Stack(children: [const Positioned(right: 16, top: 16, child: Icon(Icons.spa_outlined, size: 74, color: Color(0x44F8F3E9))), Positioned(left: 18, bottom: 18, child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: const [Text('RAGAMNUSA', style: TextStyle(color: gading, letterSpacing: 2, fontWeight: FontWeight.w900)), SizedBox(height: 5), Text('Jaga budaya, jaga Indonesia.', style: TextStyle(color: gading, fontSize: 17, fontWeight: FontWeight.w800))]))])),
      const SizedBox(height: 18),
      _surface(Column(children: [
        const CircleAvatar(radius: 31, backgroundColor: Color(0xFFEDE2D0), child: Icon(Icons.storefront_rounded, size: 32, color: kayu)),
        const SizedBox(height: 9),
        Text(nameController.text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: kayu, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.star_rounded, color: terracotta, size: 18), Text(' Rating demo · ulasan contoh', style: TextStyle(color: Color(0xFF78695D), fontSize: 12))]),
      ])),
      const SizedBox(height: 18),
      const Text('Informasi toko', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 10),
      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama toko', prefixIcon: Icon(Icons.storefront_outlined))),
      const SizedBox(height: 10),
      TextField(controller: addressController, decoration: const InputDecoration(labelText: 'Alamat toko', prefixIcon: Icon(Icons.location_on_outlined))),
      const SizedBox(height: 10),
      TextField(controller: hoursController, decoration: const InputDecoration(labelText: 'Jam operasional', prefixIcon: Icon(Icons.schedule_outlined))),
      const SizedBox(height: 10),
      TextField(controller: descriptionController, maxLines: 4, decoration: const InputDecoration(labelText: 'Deskripsi toko', alignLabelWithHint: true)),
      const SizedBox(height: 16),
      PrimaryButton('Simpan perubahan', () { if (nameController.text.trim().isEmpty || addressController.text.trim().isEmpty) { notice(context, 'Nama dan alamat toko wajib diisi.'); return; } ownerProfileData['store'] = nameController.text.trim(); ownerProfileData['address'] = addressController.text.trim(); ownerProfileData['hours'] = hoursController.text.trim(); ownerProfileData['description'] = descriptionController.text.trim(); setState(() {}); notice(context, 'Profil toko diperbarui untuk sesi ini.'); }),
      const SizedBox(height: 8),
      const Text('Foto sampul dan logo dapat ditambahkan saat integrasi pemilih gambar.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
    ]),
  );
}

class OwnerPerformancePage extends StatelessWidget {
  const OwnerPerformancePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: gading,
    appBar: AppBar(backgroundColor: gading, foregroundColor: kayu, elevation: 0, title: const Text('Statistik Performa', style: TextStyle(fontWeight: FontWeight.w900))),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Performa toko', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 4), const Text('Ringkasan contoh untuk membantu mengevaluasi bisnis.', style: TextStyle(color: Color(0xFF78695D))),
      const SizedBox(height: 16),
      Row(children: [const Expanded(child: _OwnerMetric(icon: Icons.receipt_long_outlined, label: 'Penyewaan selesai', value: '38')), const SizedBox(width: 10), const Expanded(child: _OwnerMetric(icon: Icons.star_outline_rounded, label: 'Rating rata-rata', value: '4.8/5'))]),
      const SizedBox(height: 10),
      Row(children: [const Expanded(child: _OwnerMetric(icon: Icons.trending_up_rounded, label: 'Pendapatan demo', value: 'Rp12 jt')), const SizedBox(width: 10), const Expanded(child: _OwnerMetric(icon: Icons.inventory_2_outlined, label: 'Produk aktif', value: '3'))]),
      const SizedBox(height: 22),
      const Text('Aktivitas penyewaan', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 12),
      _surface(Column(children: [
        _performanceBar('Mei', .42, '16 sewa'), const SizedBox(height: 15),
        _performanceBar('Juni', .64, '24 sewa'), const SizedBox(height: 15),
        _performanceBar('Juli', .52, '20 sewa'), const SizedBox(height: 15),
        _performanceBar('Agustus', .84, '32 sewa'), const SizedBox(height: 15),
        _performanceBar('September', 1, '38 sewa'),
      ])),
      const SizedBox(height: 22),
      const Text('Produk populer', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 10),
      _surface(Column(children: [
        _popularProduct('Paket Busana Adat Bali', '18 kali disewa', .86), const Divider(height: 22),
        _popularProduct('Gamelan Mini', '12 kali disewa', .62), const Divider(height: 22),
        _popularProduct('Paket Alat Membatik', '8 kali disewa', .42),
      ])),
      const SizedBox(height: 12),
      const Text('Seluruh angka dan grafik merupakan data simulasi, bukan laporan transaksi nyata.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
    ]),
  );

  Widget _performanceBar(String month, double value, String label) => Row(children: [SizedBox(width: 82, child: Text(month, style: const TextStyle(fontSize: 12, color: teks))), Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: value, minHeight: 10, backgroundColor: const Color(0xFFEDE2D0), color: terracotta))), const SizedBox(width: 10), SizedBox(width: 58, child: Text(label, textAlign: TextAlign.end, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))))]);
  Widget _popularProduct(String name, String count, double value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800, color: teks))), Text(count, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D)))]), const SizedBox(height: 8), ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(value: value, minHeight: 7, backgroundColor: const Color(0xFFEDE2D0), color: zaitun))]);
}

class OwnerVerificationPage extends StatelessWidget {
  const OwnerVerificationPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: gading,
    appBar: AppBar(backgroundColor: gading, foregroundColor: kayu, elevation: 0, title: const Text('Verifikasi Toko', style: TextStyle(fontWeight: FontWeight.w900))),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4E2F21), Color(0xFFA66A43)]), borderRadius: BorderRadius.circular(20)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.verified_user_outlined, color: gading, size: 36), SizedBox(height: 12), Text('Bangun kepercayaan penyewa', style: TextStyle(color: gading, fontSize: 21, fontWeight: FontWeight.w900)), SizedBox(height: 6), Text('Lengkapi informasi verifikasi agar penyewa merasa lebih aman saat menyewa produk budaya.', style: TextStyle(color: Color(0xFFF1E5D6), height: 1.4))])),
      const SizedBox(height: 18),
      _surface(Column(children: [
        _verificationRow(Icons.person_outline, 'Identitas pemilik', 'Belum diverifikasi', false), const Divider(height: 1),
        _verificationRow(Icons.storefront_outlined, 'Informasi toko', 'Perlu ditinjau', false), const Divider(height: 1),
        _verificationRow(Icons.location_on_outlined, 'Alamat toko', 'Belum diverifikasi', false),
      ])),
      const SizedBox(height: 16),
      PrimaryButton('Mulai verifikasi', () => notice(context, 'Alur unggah dokumen dan verifikasi akan ditambahkan nanti.')),
      const SizedBox(height: 10),
      const Text('Prototype ini tidak meminta atau menyimpan dokumen identitas. Status verifikasi masih berupa contoh.', style: TextStyle(fontSize: 11, height: 1.4, color: Color(0xFF78695D))),
    ]),
  );
  Widget _verificationRow(IconData icon, String title, String status, bool done) => ListTile(leading: CircleAvatar(backgroundColor: const Color(0xFFEDE2D0), child: Icon(icon, color: kayu)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: teks)), subtitle: Text(status, style: const TextStyle(fontSize: 12, color: Color(0xFF78695D))), trailing: Icon(done ? Icons.check_circle : Icons.hourglass_empty_rounded, color: done ? zaitun : terracotta));
}

class _FinanceTransaction {
  final String name, detail, method, time, status;
  final int amount;
  final bool incoming;
  final IconData icon;
  const _FinanceTransaction({required this.name, required this.detail, required this.method, required this.time, required this.status, required this.amount, required this.incoming, required this.icon});
}

class OwnerFinancePage extends StatefulWidget {
  const OwnerFinancePage({super.key});
  @override
  State<OwnerFinancePage> createState() => _OwnerFinancePageState();
}

class _OwnerFinancePageState extends State<OwnerFinancePage> {
  int period = 1; // 0 harian, 1 mingguan, 2 bulanan
  int transactionFilter = 0;
  final List<_FinanceTransaction> transactions = const [
    _FinanceTransaction(name: 'Arwin Pratama', detail: 'Sewa Kebaya Kutu Baru · RN-1028', method: 'Transfer BCA', time: 'Hari ini, 14.20', status: 'Diterima langsung', amount: 150000, incoming: true, icon: Icons.account_balance_outlined),
    _FinanceTransaction(name: 'Nadia Putri', detail: 'Sewa Gamelan Mini · RN-1027', method: 'GoPay', time: 'Hari ini, 11.05', status: 'Diterima langsung', amount: 100000, incoming: true, icon: Icons.account_balance_wallet_outlined),
    _FinanceTransaction(name: 'Dimas Saputra', detail: 'Sewa Gebyok Pelaminan · RN-1026', method: 'QRIS', time: 'Kemarin, 19.42', status: 'Diterima langsung', amount: 250000, incoming: true, icon: Icons.qr_code_2_rounded),
    _FinanceTransaction(name: 'Ayu Lestari', detail: 'Sewa Aksesori Adat · RN-1025', method: 'DANA', time: 'Kemarin, 15.10', status: 'Diterima langsung', amount: 50000, incoming: true, icon: Icons.account_balance_wallet_outlined),
    _FinanceTransaction(name: 'Rizky Maulana', detail: 'Sewa Ulos Batak · RN-1024', method: 'Tunai saat serah terima', time: '21 Okt 2026, 10.00', status: 'Tandai setelah diterima', amount: 90000, incoming: true, icon: Icons.payments_outlined),
    _FinanceTransaction(name: 'Pengembalian deposit', detail: 'Deposit pesanan RN-1018', method: 'Transfer bank', time: '20 Okt 2026, 16.30', status: 'Dana keluar', amount: 100000, incoming: false, icon: Icons.reply_rounded),
  ];
  final List<double> daily = const [180000, 240000, 90000, 350000, 200000, 420000, 300000];
  final List<double> weekly = const [950000, 1200000, 850000, 1450000, 1100000, 1750000, 1300000];
  final List<double> monthly = const [3200000, 4100000, 3800000, 5200000, 4600000, 6100000, 5700000, 7200000, 6500000, 8100000, 7600000, 9200000];
  String money(int n) => _rupiah(n);
  @override
  Widget build(BuildContext context) {
    final values = period == 0 ? daily : period == 1 ? weekly : monthly;
    final labels = period == 0 ? const ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'] : period == 1 ? const ['M-6', 'M-5', 'M-4', 'M-3', 'M-2', 'M-1', 'Kini'] : const ['Nov', 'Des', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt'];
    final total = values.fold<double>(0, (a, b) => a + b).round();
    final filtered = transactions.where((t) => transactionFilter == 0 || (transactionFilter == 1 && t.incoming) || (transactionFilter == 2 && !t.incoming)).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(18, 10, 18, 28), children: [
      Row(children: [const Expanded(child: Text('Keuangan Toko', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: teks))), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(color: const Color(0xFFE5EAD9), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.circle, size: 7, color: zaitun), SizedBox(width: 5), Text('Mode demo', style: TextStyle(fontSize: 11, color: zaitun, fontWeight: FontWeight.w800))]))]),
      const SizedBox(height: 4), const Text('Ringkasan pemasukan, kanal pembayaran, dan transaksi toko.', style: TextStyle(color: Color(0xFF78695D))),
      const SizedBox(height: 17),
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF4E2F21), Color(0xFF805035), Color(0xFFA66A43)]), borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.savings_outlined, color: Color(0xFFF1D9AE)), SizedBox(width: 8), Text('Total penerimaan sewa · simulasi', style: TextStyle(color: gading, fontSize: 12))]),
        const SizedBox(height: 10), const Text('Rp18.450.000', style: TextStyle(color: Colors.white, fontSize: 29, fontWeight: FontWeight.w900)),
        const SizedBox(height: 5), const Text('Akumulasi contoh. Bukan saldo rekening dan belum berasal dari transaksi nyata.', style: TextStyle(color: Color(0xFFF1E5D6), fontSize: 11, height: 1.4)),
        const SizedBox(height: 17), Row(children: [Expanded(child: _financeMiniMetric('Transaksi masuk', '38 transaksi')), const SizedBox(width: 12), Expanded(child: _financeMiniMetric('Deposit ditahan', 'Rp650.000'))]),
      ])),
      const SizedBox(height: 18),
      const Text('Analitik pendapatan', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 9),
      Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: kayu.withValues(alpha: .10))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SegmentedButton<int>(segments: const [ButtonSegment(value: 0, label: Text('Harian')), ButtonSegment(value: 1, label: Text('Mingguan')), ButtonSegment(value: 2, label: Text('Bulanan'))], selected: {period}, onSelectionChanged: (v) => setState(() => period = v.first), style: SegmentedButton.styleFrom(selectedBackgroundColor: const Color(0xFFE7DCCB), selectedForegroundColor: kayu, visualDensity: VisualDensity.compact)),
        const SizedBox(height: 14), Text(money(total), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: kayu)),
        Text(period == 0 ? 'Total simulasi 7 hari' : period == 1 ? 'Total simulasi 7 minggu' : 'Total simulasi 12 bulan', style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
        const SizedBox(height: 10), SizedBox(height: 175, child: CustomPaint(size: const Size(double.infinity, 175), painter: _FinanceChartPainter(values: values, labels: labels))),
        const SizedBox(height: 6), const Text('Grafik memakai data contoh agar tampilan dapat diuji. Nantinya nilai harus dihitung dari pembayaran yang terverifikasi.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D), height: 1.4)),
      ])),
      const SizedBox(height: 18), const Text('Pembayaran diterima melalui', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 10), GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.3, children: const [
        _FinanceChannel(icon: Icons.qr_code_2_rounded, title: 'QRIS', subtitle: 'Rp4.250.000'), _FinanceChannel(icon: Icons.account_balance_outlined, title: 'Transfer bank', subtitle: 'Rp7.800.000'), _FinanceChannel(icon: Icons.account_balance_wallet_outlined, title: 'GoPay / DANA', subtitle: 'Rp3.100.000'), _FinanceChannel(icon: Icons.payments_outlined, title: 'Tunai / COD', subtitle: 'Rp1.200.000'),
      ]),
      const SizedBox(height: 18),
      Row(children: [const Expanded(child: Text('Riwayat transaksi', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks))), Icon(Icons.receipt_long_outlined, color: terracotta)]),
      const SizedBox(height: 9),
      Wrap(spacing: 7, children: [ChoiceChip(label: const Text('Semua'), selected: transactionFilter == 0, onSelected: (_) => setState(() => transactionFilter = 0)), ChoiceChip(label: const Text('Uang masuk'), selected: transactionFilter == 1, onSelected: (_) => setState(() => transactionFilter = 1)), ChoiceChip(label: const Text('Uang keluar'), selected: transactionFilter == 2, onSelected: (_) => setState(() => transactionFilter = 2))]),
      const SizedBox(height: 8),
      ...filtered.map((t) => Container(margin: const EdgeInsets.only(bottom: 9), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [CircleAvatar(backgroundColor: t.incoming ? const Color(0xFFE5EAD9) : const Color(0xFFF4E0D5), child: Icon(t.icon, color: t.incoming ? zaitun : terracotta)), const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.name, style: const TextStyle(fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 3), Text(t.detail, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))), Text('${t.method} · ${t.time}', style: const TextStyle(fontSize: 10, color: Color(0xFF78695D))), Text(t.status, style: TextStyle(fontSize: 10, color: t.incoming ? zaitun : terracotta, fontWeight: FontWeight.w700))])), const SizedBox(width: 6), Text('${t.incoming ? '+' : '-'}${money(t.amount)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: t.incoming ? zaitun : terracotta))]))),
      const SizedBox(height: 6),
      Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFEDE2D0), borderRadius: BorderRadius.circular(14)), child: const Text('Penting: transaksi QRIS, bank, GoPay, DANA, dan tunai di sini hanyalah simulasi. Pembayaran langsung ke pemilik tidak dicairkan oleh RAGAMNUSA. Tandai transaksi hanya setelah dana benar-benar diterima. Deposit yang dapat dikembalikan dan ongkir harus dicatat terpisah dari pendapatan sewa.', style: TextStyle(fontSize: 11, height: 1.5, color: teks))),
    ]);
  }
}

Widget _financeMiniMetric(String label, String value) => Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: Colors.white.withValues(alpha: .10), borderRadius: BorderRadius.circular(13)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Color(0xFFF1E5D6), fontSize: 10)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14))]));

class _FinanceChannel extends StatelessWidget {
  final IconData icon; final String title, subtitle;
  const _FinanceChannel({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: kayu.withValues(alpha: .10))), child: Row(children: [Icon(icon, color: terracotta, size: 24), const SizedBox(width: 8), Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: teks)), Text(subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: kayu))]))]));
}

class _FinanceChartPainter extends CustomPainter {
  final List<double> values; final List<String> labels;
  _FinanceChartPainter({required this.values, required this.labels});
  @override
  void paint(Canvas canvas, Size size) {
    const left = 8.0, right = 8.0, top = 12.0, bottom = 27.0;
    final chart = Rect.fromLTRB(left, top, size.width-right, size.height-bottom);
    final maxValue = values.reduce((a,b) => a > b ? a : b) * 1.15;
    final gridPaint = Paint()..color = const Color(0xFFE9DFD3)..strokeWidth = 1;
    for (int i=0; i<4; i++) { final y=chart.top + chart.height*i/3; canvas.drawLine(Offset(chart.left,y), Offset(chart.right,y), gridPaint); }
    final points = <Offset>[];
    for (int i=0; i<values.length; i++) { final x = values.length == 1 ? chart.center.dx : chart.left + chart.width*i/(values.length-1); final y = chart.bottom - (values[i]/maxValue)*chart.height; points.add(Offset(x,y)); }
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
      }
    }
    final fill = Path.from(path)..lineTo(points.last.dx,chart.bottom)..lineTo(points.first.dx,chart.bottom)..close();
    canvas.drawPath(fill, Paint()..shader=const LinearGradient(colors:[Color(0x55A66A43),Color(0x05A66A43)],begin:Alignment.topCenter,end:Alignment.bottomCenter).createShader(chart));
    canvas.drawPath(path, Paint()..color=terracotta..strokeWidth=2.8..style=PaintingStyle.stroke..strokeCap=StrokeCap.round..strokeJoin=StrokeJoin.round);
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 3.5, Paint()..color = kayu);
      final painter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            fontSize: 9,
            color: Color(0xFF78695D),
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 54);
      final labelX = (points[i].dx - painter.width / 2)
          .clamp(0.0, size.width - painter.width)
          .toDouble();
      painter.paint(canvas, Offset(labelX, chart.bottom + 7));
    }
  }
  @override
  bool shouldRepaint(covariant _FinanceChartPainter oldDelegate) => oldDelegate.values != values || oldDelegate.labels != labels;
}

class RenterProfilePage extends StatelessWidget {
  final String name;
  const RenterProfilePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final storedName = renterProfileData['name'] ?? '';
    final displayName = storedName != 'Sahabat Nusantara' && storedName.trim().isNotEmpty
        ? storedName : (name.trim().isEmpty ? 'Sahabat Nusantara' : name);
    final hasAddress = (renterProfileData['address'] ?? '').trim().isNotEmpty;
    final hasContact = (renterProfileData['phone'] ?? '').trim().isNotEmpty &&
        (renterProfileData['email'] ?? '').trim().isNotEmpty;
    final hasCustomName = displayName != 'Sahabat Nusantara';
    final completed = [hasContact, hasAddress, hasCustomName].where((v) => v).length;
    final completion = completed / 3;

    return ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 32), children: [
      // HERO PENYEWA: hangat, personal, dan bernuansa Nusantara.
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF4E3022), Color(0xFF875337), Color(0xFFC88C62)]),
          boxShadow: [BoxShadow(color: const Color(0xFF6B422D).withValues(alpha: .20), blurRadius: 24, offset: const Offset(0, 12))],
        ),
        child: Stack(children: [
          const Positioned(right: -26, top: -42, child: Icon(Icons.spa_rounded, size: 190, color: Color(0x18FFFFFF))),
          const Positioned(right: 35, bottom: -54, child: Icon(Icons.blur_on_rounded, size: 140, color: Color(0x16FFFFFF))),
          Positioned(left: -25, bottom: -60, child: Container(width: 150, height: 150, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0x20FFFFFF), width: 18)))),
          Padding(padding: const EdgeInsets.all(21), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 76, height: 76, decoration: BoxDecoration(color: const Color(0xFFFFEBDD), borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0x66FFFFFF), width: 2), boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 10, offset: Offset(0, 4))]), child: const Icon(Icons.person_rounded, color: Color(0xFF6B422D), size: 46)),
              const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0x2EFFFFFF), borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0x30FFFFFF))), child: const Text('RUANG PRIBADI', style: TextStyle(color: Color(0xFFFFEBDD), fontSize: 9, letterSpacing: 1.6, fontWeight: FontWeight.w900))),
                const SizedBox(height: 9), Text(displayName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 23, height: 1.05, fontWeight: FontWeight.w900)),
                const SizedBox(height: 7), const Row(children: [Icon(Icons.explore_rounded, size: 15, color: Color(0xFFFFD9B7)), SizedBox(width: 5), Expanded(child: Text('Penjelajah warisan Nusantara', style: TextStyle(color: Color(0xFFFFEBDD), fontSize: 11.5)))])
              ])),
            ]),
            const SizedBox(height: 22),
            Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0x20FFFFFF), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0x24FFFFFF))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [const Expanded(child: Text('Buat pengalaman sewa lebih mudah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))), Text('${(completion * 100).round()}%', style: const TextStyle(color: Color(0xFFFFE0BE), fontWeight: FontWeight.w900, fontSize: 14))]),
              const SizedBox(height: 10), ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(value: completion, minHeight: 7, backgroundColor: const Color(0x40FFFFFF), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD3A7)))),
              const SizedBox(height: 9), Text(completion == 1 ? 'Mantap! Informasi dasar profilmu sudah lengkap.' : 'Lengkapi data, kontak, dan alamat agar koordinasi sewa lebih lancar.', style: const TextStyle(color: Color(0xFFF8E9DB), fontSize: 11, height: 1.4)),
            ])),
          ])),
        ]),
      ),
      const SizedBox(height: 25),
      const _ProfileSectionHeading(icon: Icons.bolt_rounded, title: 'Akses cepat', subtitle: 'Atur hal penting dalam beberapa sentuhan'),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: _ProfileActionCard(icon: Icons.badge_rounded, title: 'Data diri', subtitle: 'Nama & kontak', color: const Color(0xFF9B6545), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RenterPersonalDataPage(initialName: displayName))))),
        const SizedBox(width: 10),
        Expanded(child: _ProfileActionCard(icon: Icons.location_on_rounded, title: 'Alamat', subtitle: hasAddress ? 'Sudah diisi' : 'Tambahkan', color: const Color(0xFF78805B), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RenterAddressPage())))),
        const SizedBox(width: 10),
        Expanded(child: _ProfileActionCard(icon: Icons.tune_rounded, title: 'Preferensi', subtitle: 'Atur sewa', color: const Color(0xFFB47B52), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RentalPreferencesPage())))),
      ]),
      const SizedBox(height: 24),
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFFFFBF5), borderRadius: BorderRadius.circular(25), border: Border.all(color: const Color(0xFFE8D9C9)), boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 14, offset: Offset(0, 5))]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Container(width: 44, height: 44, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF1E0D0), Color(0xFFE8CBB1)]), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.local_shipping_rounded, color: Color(0xFF805237))), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Siap untuk sewa berikutnya?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: teks)), SizedBox(height: 4), Text('Cek dua hal ini sebelum melakukan pemesanan.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D)))]))]),
        const SizedBox(height: 15),
        _ProfileChecklistRow(done: hasContact, title: hasContact ? 'Kontak akun sudah lengkap' : 'Lengkapi nomor telepon dan email', action: hasContact ? null : 'Lengkapi', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RenterPersonalDataPage(initialName: displayName)))),
        const SizedBox(height: 8),
        _ProfileChecklistRow(done: hasAddress, title: hasAddress ? 'Alamat pengantaran sudah siap' : 'Tambahkan alamat pengantaran', action: hasAddress ? null : 'Tambah', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RenterAddressPage()))),
      ])),
      const SizedBox(height: 25),
      const _ProfileSectionHeading(icon: Icons.shield_moon_rounded, title: 'Bantuan & perlindungan', subtitle: 'Jaga pengalaman sewa tetap nyaman'),
      const SizedBox(height: 12),
      _ProfileMenuTile(icon: Icons.notifications_active_outlined, title: 'Pengaturan aplikasi', subtitle: 'Notifikasi dan privasi akun', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()))),
      _ProfileMenuTile(icon: Icons.support_agent_rounded, title: 'Pusat bantuan', subtitle: 'Pertanyaan dan laporan kendala sewa', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpDisputePage()))),
      Container(margin: const EdgeInsets.only(top: 8), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFECE8D9), borderRadius: BorderRadius.circular(21)), child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.verified_user_rounded, color: Color(0xFF66704D), size: 25), SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Sewa dengan tenang', style: TextStyle(fontWeight: FontWeight.w900, color: teks)), SizedBox(height: 5), Text('Simpan bukti komunikasi dan pembayaran. Periksa kondisi barang saat diterima maupun dikembalikan.', style: TextStyle(fontSize: 12, height: 1.45, color: Color(0xFF686A55)))]))])),
      const SizedBox(height: 18),
      OutlinedButton.icon(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false), icon: const Icon(Icons.logout_rounded), label: const Text('Keluar dari akun'), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF805237), side: const BorderSide(color: Color(0xFFD8C4B1)), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)))),
      const SizedBox(height: 14), const Center(child: Text('RAGAMNUSA  •  Merawat cerita Nusantara', style: TextStyle(fontSize: 10, letterSpacing: .3, color: Color(0xFF9A8A7C)))),
    ]);
  }
}

class OwnerProfilePage extends StatelessWidget {
  final String name;
  final String shopName;
  const OwnerProfilePage({super.key, required this.name, required this.shopName});

  @override
  Widget build(BuildContext context) {
    final storedName = ownerProfileData['name'] ?? '';
    final displayName = storedName != 'Pemilik Budaya' && storedName.trim().isNotEmpty ? storedName : (name.trim().isEmpty ? 'Pemilik Budaya' : name);
    final storedShop = ownerProfileData['store'] ?? '';
    final displayShop = storedShop != 'Toko Sari Budaya' && storedShop.trim().isNotEmpty ? storedShop : (shopName.trim().isEmpty ? 'Toko Sari Budaya' : shopName);
    final hasAddress = (ownerProfileData['address'] ?? '').trim().isNotEmpty;
    final hasRules = (ownerProfileData['rules'] ?? '').trim().isNotEmpty;
    final hasDescription = (ownerProfileData['description'] ?? '').trim().isNotEmpty;
    final setupCount = [displayShop != 'Toko Sari Budaya', hasAddress, hasRules, hasDescription].where((v) => v).length;
    final setupProgress = setupCount / 4;

    return ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 32), children: [
      // HERO PEMILIK: lebih editorial, profesional, dan berorientasi usaha.
      Container(clipBehavior: Clip.antiAlias, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF25291F), Color(0xFF414936), Color(0xFF697052)]), boxShadow: [BoxShadow(color: const Color(0xFF292D22).withValues(alpha: .22), blurRadius: 24, offset: const Offset(0, 12))]), child: Stack(children: [
        const Positioned(right: -24, top: -37, child: Icon(Icons.store_mall_directory_rounded, size: 190, color: Color(0x16FFFFFF))),
        const Positioned(right: 35, bottom: -48, child: Icon(Icons.grass_rounded, size: 150, color: Color(0x16FFFFFF))),
        Positioned(left: -35, top: 105, child: Container(width: 125, height: 125, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0x18FFFFFF), width: 16)))),
        Padding(padding: const EdgeInsets.all(21), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Container(width: 74, height: 74, decoration: BoxDecoration(color: const Color(0xFFE8D7BD), borderRadius: BorderRadius.circular(23), border: Border.all(color: const Color(0x55FFFFFF), width: 2), boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 10, offset: Offset(0, 4))]), child: const Icon(Icons.storefront_rounded, size: 42, color: Color(0xFF51432E))), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0x2FFFFFFF), borderRadius: BorderRadius.circular(30), border: Border.all(color: const Color(0x25FFFFFF))), child: const Text('RUANG MITRA', style: TextStyle(color: Color(0xFFE2E4C8), fontSize: 9, letterSpacing: 1.6, fontWeight: FontWeight.w900))), const SizedBox(height: 9), Text(displayName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 22, height: 1.05, fontWeight: FontWeight.w900)), const SizedBox(height: 6), const Text('Pemilik & pelestari budaya', style: TextStyle(color: Color(0xFFE4E0D1), fontSize: 11.5))]))]),
          const SizedBox(height: 22), Container(height: 1, color: const Color(0x33FFFFFF)), const SizedBox(height: 16),
          Row(children: [Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0x22FFFFFF), borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.store_rounded, color: Color(0xFFE2E4C8))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('TOKO YANG KAMU KELOLA', style: TextStyle(color: Color(0xFFC9C8A4), fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w900)), const SizedBox(height: 5), Text(displayShop, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 21, height: 1.1, fontWeight: FontWeight.w900))]))]),
          const SizedBox(height: 11), Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFFD9D9B8)), const SizedBox(width: 6), Expanded(child: Text(hasAddress ? ownerProfileData['address']! : 'Tambahkan alamat usaha agar penyewa mengenal lokasi tokomu', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFE4E0D1), fontSize: 11, height: 1.35)))]),
          const SizedBox(height: 17), Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0x1FFFFFFF), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0x20FFFFFF))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const Expanded(child: Text('Kesiapan profil usaha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12))), Text('${(setupProgress * 100).round()}%', style: const TextStyle(color: Color(0xFFE2E4C8), fontSize: 14, fontWeight: FontWeight.w900))]), const SizedBox(height: 10), ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(value: setupProgress, minHeight: 7, backgroundColor: const Color(0x40FFFFFF), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD9DDB6)))), const SizedBox(height: 9), Text(setupCount == 4 ? 'Profil usaha siap membantu membangun kepercayaan.' : 'Lengkapi toko, lokasi, deskripsi, dan aturan sewa agar calon penyewa mendapat informasi yang jelas.', style: const TextStyle(color: Color(0xFFE4E0D1), fontSize: 11, height: 1.4))])),
        ])),
      ])),
      const SizedBox(height: 25),
      const _ProfileSectionHeading(icon: Icons.dashboard_customize_rounded, title: 'Kelola tokomu', subtitle: 'Bangun etalase yang jelas dan terpercaya'),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: _ProfileActionCard(icon: Icons.storefront_rounded, title: 'Profil toko', subtitle: 'Etalase publik', color: const Color(0xFF66704D), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerShopProfilePage(shopName: displayShop))))),
        const SizedBox(width: 10),
        Expanded(child: _ProfileActionCard(icon: Icons.fact_check_rounded, title: 'Verifikasi', subtitle: 'Kepercayaan', color: const Color(0xFF9A7650), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerVerificationPage())))),
        const SizedBox(width: 10),
        Expanded(child: _ProfileActionCard(icon: Icons.rule_rounded, title: 'Aturan sewa', subtitle: hasRules ? 'Sudah diatur' : 'Atur aturan', color: const Color(0xFF7C8061), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OwnerRentalRulesPage())))),
      ]),
      const SizedBox(height: 23),
      Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFE9EBD9), Color(0xFFDDE1CA)]), borderRadius: BorderRadius.circular(23), border: Border.all(color: const Color(0xFFD3D8BF))), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFFD0D7B8), borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.handshake_rounded, color: Color(0xFF596044), size: 25)), const SizedBox(width: 12), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Toko rapi, penyewa lebih tenang', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: teks)), SizedBox(height: 5), Text('Jelaskan kondisi barang, deposit, durasi sewa, dan proses pengembalian sebelum transaksi. Informasi yang jelas membantu mengurangi salah paham.', style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF686A55)))]))])),
      const SizedBox(height: 25),
      const _ProfileSectionHeading(icon: Icons.admin_panel_settings_rounded, title: 'Akun & keamanan', subtitle: 'Jaga informasi dan komunikasi tetap tertata'),
      const SizedBox(height: 12),
      _ProfileMenuTile(icon: Icons.manage_accounts_rounded, title: 'Identitas pemilik', subtitle: 'Nama dan kontak pengelola', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerIdentityPage(initialName: displayName)))),
      _ProfileMenuTile(icon: Icons.support_agent_rounded, title: 'Pusat bantuan & sengketa', subtitle: 'Bantuan untuk kendala transaksi', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpDisputePage()))),
      _ProfileMenuTile(icon: Icons.settings_suggest_rounded, title: 'Pengaturan aplikasi', subtitle: 'Notifikasi dan privasi akun', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()))),
      const SizedBox(height: 10),
      OutlinedButton.icon(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false), icon: const Icon(Icons.logout_rounded), label: const Text('Keluar dari akun'), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF596044), side: const BorderSide(color: Color(0xFFCCD0B8)), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)))),
      const SizedBox(height: 14), const Center(child: Text('RAGAMNUSA  •  Mitra pelestari budaya', style: TextStyle(fontSize: 10, letterSpacing: .3, color: Color(0xFF9A8A7C)))),
    ]);
  }
}

class _ProfileSectionHeading extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _ProfileSectionHeading({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(width: 39, height: 39, decoration: BoxDecoration(color: const Color(0xFFEDE3D6), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: kayu, size: 21)),
    const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF817366), height: 1.35))])),
  ]);
}

class _ProfileChecklistRow extends StatelessWidget {
  final bool done;
  final String title;
  final String? action;
  final VoidCallback onTap;
  const _ProfileChecklistRow({required this.done, required this.title, required this.action, required this.onTap});
  @override
  Widget build(BuildContext context) => Row(children: [Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 18, color: done ? zaitun : const Color(0xFFB58A63)), const SizedBox(width: 9), Expanded(child: Text(title, style: const TextStyle(fontSize: 12, color: teks))), if (action != null) TextButton(onPressed: onTap, style: TextButton.styleFrom(visualDensity: VisualDensity.compact), child: Text(action!))]);
}

class RenterPersonalDataPage extends StatefulWidget {
  final String initialName;
  const RenterPersonalDataPage({super.key, required this.initialName});
  @override State<RenterPersonalDataPage> createState() => _RenterPersonalDataPageState();
}
class _RenterPersonalDataPageState extends State<RenterPersonalDataPage> {
  late final name = TextEditingController(text: renterProfileData['name'] == 'Sahabat Nusantara' ? widget.initialName : renterProfileData['name']);
  late final phone = TextEditingController(text: renterProfileData['phone']);
  late final email = TextEditingController(text: renterProfileData['email']);
  @override void dispose() { name.dispose(); phone.dispose(); email.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: gading, appBar: AppBar(title: const Text('Data pribadi')), body: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Informasi akun', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 6), const Text('Pastikan kontak aktif agar pemilik mudah menghubungimu terkait pesanan.'), const SizedBox(height: 18),
    TextField(controller: name, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nama lengkap', prefixIcon: Icon(Icons.person_outline))), const SizedBox(height: 12),
    TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor telepon', prefixIcon: Icon(Icons.phone_outlined))), const SizedBox(height: 12),
    TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline))), const SizedBox(height: 18),
    PrimaryButton('Simpan data', () { if (name.text.trim().isEmpty) { notice(context, 'Nama lengkap tidak boleh kosong.'); return; } renterProfileData['name'] = name.text.trim(); renterProfileData['phone'] = phone.text.trim(); renterProfileData['email'] = email.text.trim(); notice(context, 'Data pribadi diperbarui untuk sesi ini.'); Navigator.pop(context); }),
    const SizedBox(height: 10), const Text('Data tersimpan selama aplikasi berjalan. Integrasi akun/backend diperlukan untuk penyimpanan permanen.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
  ]));
}

class RenterAddressPage extends StatefulWidget { const RenterAddressPage({super.key}); @override State<RenterAddressPage> createState() => _RenterAddressPageState(); }
class _RenterAddressPageState extends State<RenterAddressPage> {
  late final address = TextEditingController(text: renterProfileData['address']);
  late final city = TextEditingController(text: renterProfileData['city']);
  late final notes = TextEditingController(text: renterProfileData['notes']);
  @override void dispose() { address.dispose(); city.dispose(); notes.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: gading, appBar: AppBar(title: const Text('Buku alamat')), body: ListView(padding: const EdgeInsets.all(18), children: [
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFEDE5D8), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.local_shipping_outlined, color: kayu, size: 30), SizedBox(width: 12), Expanded(child: Text('Alamat membantu pemilik memperkirakan pengantaran. Pastikan detail lokasi mudah ditemukan.', style: TextStyle(height: 1.4, color: teks)))])), const SizedBox(height: 18),
    TextField(controller: address, maxLines: 2, decoration: const InputDecoration(labelText: 'Alamat lengkap', hintText: 'Nama jalan, nomor rumah, RT/RW', prefixIcon: Icon(Icons.home_outlined), alignLabelWithHint: true)), const SizedBox(height: 12),
    TextField(controller: city, decoration: const InputDecoration(labelText: 'Kota / Kabupaten', prefixIcon: Icon(Icons.location_city_outlined))), const SizedBox(height: 12),
    TextField(controller: notes, maxLines: 3, decoration: const InputDecoration(labelText: 'Patokan / catatan kurir', hintText: 'Warna pagar, nama gedung, jam penerimaan', alignLabelWithHint: true)), const SizedBox(height: 18),
    PrimaryButton('Simpan alamat', () { if (address.text.trim().isEmpty || city.text.trim().isEmpty) { notice(context, 'Alamat dan kota wajib diisi.'); return; } renterProfileData['address'] = address.text.trim(); renterProfileData['city'] = city.text.trim(); renterProfileData['notes'] = notes.text.trim(); notice(context, 'Alamat tersimpan untuk sesi ini.'); Navigator.pop(context); }),
  ]));
}

class RentalPreferencesPage extends StatefulWidget { const RentalPreferencesPage({super.key}); @override State<RentalPreferencesPage> createState() => _RentalPreferencesPageState(); }
class _RentalPreferencesPageState extends State<RentalPreferencesPage> {
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: gading, appBar: AppBar(title: const Text('Preferensi sewa')), body: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Cara sewa yang nyaman', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 6), const Text('Pilih pengingat dan metode penerimaan yang paling cocok untukmu.'), const SizedBox(height: 18),
    Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(children: [
      SwitchListTile(value: renterPreferences['chat']!, onChanged: (v) => setState(() => renterPreferences['chat'] = v), activeThumbColor: kayu, title: const Text('Pemberitahuan chat'), subtitle: const Text('Pesan dari pemilik terkait sewa')),
      const Divider(height: 1), SwitchListTile(value: renterPreferences['delivery']!, onChanged: (v) => setState(() => renterPreferences['delivery'] = v), activeThumbColor: kayu, title: const Text('Utamakan pengantaran'), subtitle: const Text('Jika produk dan pemilik menyediakan opsi ini')),
      const Divider(height: 1), SwitchListTile(value: renterPreferences['pickup']!, onChanged: (v) => setState(() => renterPreferences['pickup'] = v), activeThumbColor: kayu, title: const Text('Utamakan ambil sendiri'), subtitle: const Text('Konfirmasi lokasi dan waktu dengan pemilik')),
      const Divider(height: 1), SwitchListTile(value: renterPreferences['reminder']!, onChanged: (v) => setState(() => renterPreferences['reminder'] = v), activeThumbColor: kayu, title: const Text('Pengingat pengembalian'), subtitle: const Text('Pengingat lokal demo, belum berupa notifikasi perangkat')),
    ])), const SizedBox(height: 16), PrimaryButton('Simpan preferensi', () { notice(context, 'Preferensi diperbarui untuk sesi ini.'); Navigator.pop(context); }),
  ]));
}

class OwnerIdentityPage extends StatefulWidget { final String initialName; const OwnerIdentityPage({super.key, required this.initialName}); @override State<OwnerIdentityPage> createState() => _OwnerIdentityPageState(); }
class _OwnerIdentityPageState extends State<OwnerIdentityPage> {
  late final name = TextEditingController(text: ownerProfileData['name'] == 'Pemilik Budaya' ? widget.initialName : ownerProfileData['name']);
  late final phone = TextEditingController(text: ownerProfileData['phone']);
  late final email = TextEditingController(text: ownerProfileData['email']);
  @override void dispose() { name.dispose(); phone.dispose(); email.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: gading, appBar: AppBar(title: const Text('Identitas pemilik')), body: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Kenali mitra toko', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 6), const Text('Kontak yang benar memudahkan koordinasi pengiriman, pengembalian, dan penyelesaian kendala.'), const SizedBox(height: 18),
    TextField(controller: name, decoration: const InputDecoration(labelText: 'Nama pemilik', prefixIcon: Icon(Icons.person_outline))), const SizedBox(height: 12), TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor telepon', prefixIcon: Icon(Icons.phone_outlined))), const SizedBox(height: 12), TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline))), const SizedBox(height: 18),
    PrimaryButton('Simpan identitas', () { if (name.text.trim().isEmpty) { notice(context, 'Nama pemilik wajib diisi.'); return; } ownerProfileData['name'] = name.text.trim(); ownerProfileData['phone'] = phone.text.trim(); ownerProfileData['email'] = email.text.trim(); notice(context, 'Identitas pemilik diperbarui untuk sesi ini.'); Navigator.pop(context); }), const SizedBox(height: 10), const Text('Prototype lokal: belum ada verifikasi kontak atau penyimpanan server.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
  ]));
}

class OwnerRentalRulesPage extends StatefulWidget { const OwnerRentalRulesPage({super.key}); @override State<OwnerRentalRulesPage> createState() => _OwnerRentalRulesPageState(); }
class _OwnerRentalRulesPageState extends State<OwnerRentalRulesPage> {
  late final rules = TextEditingController(text: ownerProfileData['rules']);
  @override void dispose() { rules.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(backgroundColor: gading, appBar: AppBar(title: const Text('Aturan sewa')), body: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Aturan yang jelas melindungi kedua pihak', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)), const SizedBox(height: 7), const Text('Tuliskan aturan yang bisa dipahami sebelum penyewa melakukan pembayaran.'), const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFE7E8D9), borderRadius: BorderRadius.circular(18)), child: const Text('Sebaiknya jelaskan: durasi sewa, tenggat pengembalian, biaya keterlambatan, ketentuan deposit, dokumentasi kondisi barang, dan prosedur jika barang rusak.', style: TextStyle(height: 1.5, color: teks))), const SizedBox(height: 14),
    TextField(controller: rules, minLines: 7, maxLines: 12, maxLength: 1200, decoration: const InputDecoration(labelText: 'Ketentuan toko', alignLabelWithHint: true, hintText: 'Tuliskan aturan sewa secara rinci')), const SizedBox(height: 16),
    PrimaryButton('Simpan aturan', () { if (rules.text.trim().isEmpty) { notice(context, 'Aturan sewa tidak boleh kosong.'); return; } ownerProfileData['rules'] = rules.text.trim(); notice(context, 'Aturan tersimpan untuk sesi ini. Pastikan aturan ditampilkan kepada penyewa sebelum transaksi.'); Navigator.pop(context); }), const SizedBox(height: 10), const Text('Aturan ini tersimpan di memori aplikasi saat ini; belum otomatis tampil di halaman produk atau tersinkron ke server.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
  ]));
}

class _ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  final VoidCallback onTap;
  const _ProfileActionCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white, borderRadius: BorderRadius.circular(20),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(20), child: Padding(
      padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 43, height: 43, decoration: BoxDecoration(color: color.withValues(alpha: .13), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: color, size: 23)),
        const SizedBox(height: 13), Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF302820))),
        const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF817366))),
      ]),
    )),
  );
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const _ProfileMenuTile({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: ListTile(
      onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFF3EADF), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: kayu, size: 22)),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF302820))),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF817366))),
      trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFAA9887)),
    ),
  );
}

int _parsePrice(String value) {
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(digits) ?? 75000;
}

int _parseNominal(String value) {
  // Terima input seperti 20000, 20.000, Rp 20.000, 20,000, atau 1.500.000.
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(digits) ?? 0;
}

String _formatRibuan(String digits) {
  final clean = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');
  if (clean.isEmpty) return '';
  return clean.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
}

/// Mengubah nominal saat diketik: 20000 -> 20.000.
/// Jika pengguna menempelkan teks dengan Rp, titik, atau koma, semua tetap dinormalisasi.
class NominalRupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsBeforeCursor = newValue.text
        .substring(0, newValue.selection.extentOffset.clamp(0, newValue.text.length).toInt())
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final formatted = _formatRibuan(digits);
    var cursor = 0;
    var seenDigits = 0;
    while (cursor < formatted.length && seenDigits < digitsBeforeCursor) {
      if (RegExp(r'[0-9]').hasMatch(formatted[cursor])) seenDigits++;
      cursor++;
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursor),
      composing: TextRange.empty,
    );
  }
}

String _rupiah(int value) => 'Rp${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';

class PaymentPage extends StatefulWidget {
  final String productTitle;
  final int pricePerDay;
  final DateTime startDate, endDate;
  const PaymentPage({super.key, required this.productTitle, required this.pricePerDay, required this.startDate, required this.endDate});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String method = 'QRIS';
  String bank = 'BCA';
  String wallet = 'GoPay';
  String courier = 'Kurir toko';
  bool agree = false;
  final int deposit = 100000;

  static const banks = ['BCA', 'BRI', 'BNI', 'Bank Mandiri', 'BSI', 'CIMB Niaga', 'SeaBank', 'Bank Jago', 'BTN', 'Danamon', 'PermataBank', 'Maybank', 'OCBC', 'Bank Mega', 'Bank Neo Commerce', 'BTPN/Jenius', 'Bank Muamalat', 'Bank Panin', 'Bank Sinarmas', 'Bank DKI', 'Bank Jatim', 'Bank Jateng', 'Bank Sumut', 'Bank Nagari', 'Bankaltimtara'];
  static const wallets = ['GoPay', 'OVO', 'DANA', 'ShopeePay', 'LinkAja', 'AstraPay', 'i.saku', 'Sakuku', 'Jenius Pay', 'MotionPay'];
  static const couriers = ['Kurir toko', 'JNE', 'J&T Express', 'SiCepat', 'AnterAja', 'Pos Indonesia', 'TIKI', 'Lion Parcel', 'Ninja Xpress', 'ID Express', 'SPX Express', 'GoSend', 'GrabExpress', 'Ambil sendiri'];
  String speed = 'Reguler';
  bool bubbleWrap = false;
  bool sturdyBox = false;
  bool extraPadding = false;
  bool waterproofWrap = false;
  final recipientController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void dispose() {
    recipientController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = widget.endDate.difference(widget.startDate).inDays + 1;
    final rental = days * widget.pricePerDay;
    final delivery = courier == 'Ambil sendiri' ? 0 : speed == 'Reguler' ? 15000 : 30000;
    final packaging = (bubbleWrap ? 5000 : 0) + (sturdyBox ? 8000 : 0) + (extraPadding ? 7000 : 0) + (waterproofWrap ? 3000 : 0);
    final adminFee = method == 'QRIS' ? 1000 : method == 'Transfer bank' ? 2500 : method == 'E-wallet' ? 1500 : 0;
    final total = rental + deposit + delivery + packaging + adminFee;
    final paymentDetail = method == 'Transfer bank' ? bank : method == 'E-wallet' ? wallet : method;
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran'), backgroundColor: gading),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Ringkasan pesanan', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
        const SizedBox(height: 12),
        _surface(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.productTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          _summaryRow('Tanggal mulai', _dateLabel(widget.startDate)),
          _summaryRow('Tanggal selesai', _dateLabel(widget.endDate)),
          _summaryRow('Durasi sewa', '$days hari'),
          _summaryRow('Sewa produk', _rupiah(rental)),
          _summaryRow('Deposit (dapat dikembalikan sesuai kondisi barang)', _rupiah(deposit)),
          _summaryRow('Pengiriman', delivery == 0 ? 'Gratis (ambil sendiri)' : '$courier ($speed) · ${_rupiah(delivery)}'),
          _summaryRow('Kemasan tambahan', packaging == 0 ? 'Tidak ada' : _rupiah(packaging)),
          _summaryRow('Biaya admin pembayaran', _rupiah(adminFee)),
          const Divider(height: 24),
          _summaryRow('Total yang dibayar', _rupiah(total), bold: true),
        ])),
        const SizedBox(height: 20),
        const Text('Data penerima dan alamat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        TextField(controller: recipientController, decoration: const InputDecoration(labelText: 'Nama penerima', prefixIcon: Icon(Icons.person_outline))),
        const SizedBox(height: 10),
        TextField(controller: phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Nomor telepon aktif', prefixIcon: Icon(Icons.phone_outlined))),
        const SizedBox(height: 10),
        TextField(controller: addressController, minLines: 2, maxLines: 3, decoration: const InputDecoration(labelText: 'Alamat lengkap / titik pengambilan', prefixIcon: Icon(Icons.location_on_outlined))),
        const SizedBox(height: 10),
        TextField(controller: notesController, maxLines: 2, decoration: const InputDecoration(labelText: 'Catatan untuk pemilik/kurir (opsional)', hintText: 'Patokan alamat, jam penerimaan, dll.')),
        const SizedBox(height: 20),
        const Text('Pilih pengiriman / kurir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(initialValue: courier, isExpanded: true, decoration: const InputDecoration(labelText: 'Layanan kurir'), items: couriers.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(), onChanged: (v) => setState(() => courier = v ?? courier)),
        const SizedBox(height: 10),
        if (courier != 'Ambil sendiri') SegmentedButton<String>(segments: const [ButtonSegment(value: 'Reguler', label: Text('Reguler'), icon: Icon(Icons.local_shipping_outlined)), ButtonSegment(value: 'Express', label: Text('Express'), icon: Icon(Icons.bolt))], selected: {speed}, onSelectionChanged: (v) => setState(() => speed = v.first)),
        const SizedBox(height: 6),
        Text(courier == 'Ambil sendiri' ? 'Tanpa biaya pengiriman' : 'Estimasi demo: ${speed == 'Reguler' ? 'Rp15.000' : 'Rp30.000'} · biaya nyata perlu cek kurir', style: const TextStyle(fontSize: 12, color: Color(0xFF78695D))),
        const SizedBox(height: 16),
        const Text('Kemasan tambahan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text('Opsional untuk membantu melindungi produk selama pengiriman.', style: TextStyle(fontSize: 12, color: Color(0xFF78695D))),
        CheckboxListTile(value: bubbleWrap, activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Bubble wrap'), subtitle: const Text('Tambahan bantalan · Rp5.000'), onChanged: (v) => setState(() => bubbleWrap = v ?? false)),
        CheckboxListTile(value: sturdyBox, activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Box tambahan'), subtitle: const Text('Kotak pelindung · Rp8.000'), onChanged: (v) => setState(() => sturdyBox = v ?? false)),
        CheckboxListTile(value: extraPadding, activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Bantalan pelindung ekstra'), subtitle: const Text('Foam/kertas pelindung · Rp7.000'), onChanged: (v) => setState(() => extraPadding = v ?? false)),
        CheckboxListTile(value: waterproofWrap, activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Bungkus tahan air'), subtitle: const Text('Lapisan pelindung air · Rp3.000'), onChanged: (v) => setState(() => waterproofWrap = v ?? false)),
        const SizedBox(height: 12),
        _surface(const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Keamanan dan pengembalian', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: kayu)),
          SizedBox(height: 7),
          Text('Sebelum barang dikirim, pemilik dan penyewa sebaiknya menyimpan foto kondisi serta daftar kelengkapan. Saat pengembalian, kedua pihak memeriksa kondisi barang dan mencatat bukti serah terima.', style: TextStyle(height: 1.45)),
          SizedBox(height: 6),
          Text('Deposit bukan biaya tambahan permanen. Pengembalian atau potongan harus mengikuti perjanjian dan bukti kondisi barang.', style: TextStyle(fontSize: 12, height: 1.4, color: Color(0xFF78695D))),
        ])),
        const SizedBox(height: 12),
        const Text('Metode pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        RadioGroup<String>(
          groupValue: method,
          onChanged: (value) {
            if (value != null) setState(() => method = value);
          },
          child: Column(
            children: ['QRIS', 'Transfer bank', 'E-wallet',
              'Bayar di tempat (konfirmasi pemilik)'].map((item) => Card(
              color: Colors.white,
              child: RadioListTile<String>(
                value: item,
                fillColor: WidgetStatePropertyAll(kayu),
                title: Text(item),
                secondary: Icon(
                  item == 'QRIS'
                      ? Icons.qr_code_2
                      : item == 'E-wallet'
                          ? Icons.account_balance_wallet_outlined
                          : Icons.account_balance_outlined,
                  color: kayu,
                ),
              ),
            )).toList(),
          ),
        ),
        const SizedBox(height: 4),
        Text('Biaya admin metode ini: ${_rupiah(method == 'QRIS' ? 1000 : method == 'Transfer bank' ? 2500 : method == 'E-wallet' ? 1500 : 0)} (simulasi demo)', style: const TextStyle(fontSize: 12, color: Color(0xFF78695D))),
        if (method == 'Transfer bank') ...[
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(initialValue: bank, decoration: const InputDecoration(labelText: 'Pilih bank'), items: banks.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => bank = v ?? bank)),
          const SizedBox(height: 8),
          _paymentInfo('Nomor rekening demo $bank', bank == 'BCA' ? '1234567890' : '880012345678', 'a.n. RAGAMNUSA DEMO'),
        ],
        if (method == 'E-wallet') ...[
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(initialValue: wallet, decoration: const InputDecoration(labelText: 'Pilih e-wallet'), items: wallets.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => wallet = v ?? wallet)),
          const SizedBox(height: 8),
          _paymentInfo('Nomor $wallet demo', '081234567890', 'a.n. RAGAMNUSA DEMO'),
        ],
        if (method == 'QRIS') ...[
          const SizedBox(height: 12),
          _surface(Column(children: [
            const Text('QRIS RAGAMNUSA (CONTOH)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            Container(width: 220, height: 220, padding: const EdgeInsets.all(12), color: Colors.white, child: CustomPaint(painter: _DemoQrPainter())),
            const SizedBox(height: 10),
            Text(_rupiah(total), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: kayu)),
            const SizedBox(height: 6),
            const Text('QR ini hanya ilustrasi untuk demo, bukan QRIS aktif dan tidak dapat menerima pembayaran.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            OutlinedButton.icon(onPressed: () async { await Clipboard.setData(ClipboardData(text: 'RAGAMNUSA DEMO\nProduk: ${widget.productTitle}\nTotal: ${_rupiah(total)}\nQRIS belum aktif')); if (context.mounted) notice(context, 'Ringkasan pembayaran disalin.'); }, icon: const Icon(Icons.copy), label: const Text('Salin detail pembayaran')),
            const Text('Untuk menyimpan gambar QRIS aktif, aplikasi perlu integrasi payment gateway.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black54)),
          ])),
        ],
        const SizedBox(height: 12),
        _surface(const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Tentang deposit', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)), SizedBox(height: 6), Text('Deposit adalah jaminan selama masa sewa. Pembatalan tidak memotong deposit. Deposit hanya dapat dipotong untuk kerusakan barang yang terbukti, setelah pemeriksaan dan kesempatan mengajukan sengketa. Barang kembali baik berarti deposit dikembalikan penuh.') ])),
        const SizedBox(height: 8),
        const Text('Mode demo: rekening, e-wallet, ongkir, dan QR di atas bukan transaksi sungguhan. Biaya kurir final perlu diverifikasi dengan layanan pengiriman.', style: TextStyle(fontSize: 12, color: Color(0xFF78695D))),
        CheckboxListTile(value: agree, activeColor: kayu, contentPadding: EdgeInsets.zero, onChanged: (v) => setState(() => agree = v ?? false), title: const Text('Saya menyetujui ketentuan sewa, deposit, pengiriman, dan sengketa.', style: TextStyle(fontSize: 13))),
        PrimaryButton('Konfirmasi Pesanan', () {
          if (recipientController.text.trim().isEmpty || phoneController.text.trim().isEmpty || addressController.text.trim().isEmpty) { notice(context, 'Lengkapi nama, nomor telepon, dan alamat penerima.'); return; }
                  if (!agree) { notice(context, 'Setujui ketentuan sewa terlebih dahulu.'); return; }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentResultPage(productTitle: widget.productTitle, total: total, method: '$method ($paymentDetail)', startDate: widget.startDate, endDate: widget.endDate)));
        }),
      ]),
    );
  }

  Widget _paymentInfo(String title, String number, String owner) => _surface(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 5), SelectableText(number, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kayu)), Text(owner), Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: () async { await Clipboard.setData(ClipboardData(text: number)); if (mounted) notice(context, 'Nomor pembayaran disalin.'); }, icon: const Icon(Icons.copy), label: const Text('Salin nomor')))]));
}

class _DemoQrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white;
    final black = Paint()..color = Colors.black;
    canvas.drawRect(Offset.zero & size, white);
    const n = 29;
    final cell = size.width / n;
    // Pola dekoratif semata; bukan data QR pembayaran yang dapat dipindai.
    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        final finder = _finder(x, y, 0, 0) || _finder(x, y, n - 7, 0) || _finder(x, y, 0, n - 7);
        final dark = finder || ((x * 13 + y * 7 + x * y) % 5 < 2);
        if (dark) canvas.drawRect(Rect.fromLTWH(x * cell, y * cell, cell, cell), black);
      }
    }
  }
  bool _finder(int x, int y, int left, int top) {
    final dx = x - left, dy = y - top;
    if (dx < 0 || dx >= 7 || dy < 0 || dy >= 7) return false;
    return dx == 0 || dx == 6 || dy == 0 || dy == 6 || (dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaymentResultPage extends StatelessWidget {
  final String productTitle, method;
  final int total;
  final DateTime startDate, endDate;
  const PaymentResultPage({super.key, required this.productTitle, required this.total, required this.method, required this.startDate, required this.endDate});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Pesanan dibuat')), body: Center(child: ListView(shrinkWrap: true, padding: const EdgeInsets.all(24), children: [
    const Icon(Icons.check_circle_outline, color: zaitun, size: 82), const SizedBox(height: 14),
    const Text('Pesanan berhasil dibuat!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8), const Text('Ini simulasi frontend. Status dan pembayaran belum tersimpan ke database.', textAlign: TextAlign.center), const SizedBox(height: 20),
    _surface(Column(children: [_summaryRow('Produk', productTitle), _summaryRow('Total termasuk deposit dan kurir', _rupiah(total), bold: true), _summaryRow('Metode', method), _summaryRow('Status', 'Menunggu konfirmasi pemilik') ])),
    const SizedBox(height: 12), PrimaryButton('Form Serah Terima', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HandoverPage(productTitle: 'Produk demo', deposit: 100000)))),
    const SizedBox(height: 10), PrimaryButton('Lihat Pesanan', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersPage()))),
  ])));
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool demoReviewed = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pesanan Saya')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [Icon(Icons.check_circle, color: zaitun), SizedBox(width: 8), Expanded(child: Text('Contoh pesanan selesai', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)))]),
          const SizedBox(height: 8),
          const Text('Kebaya Jawa · Toko Sari Budaya'),
          const SizedBox(height: 4),
          const Text('Status: Selesai dikembalikan', style: TextStyle(color: zaitun, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          if (demoReviewed)
            const Chip(avatar: Icon(Icons.star, color: Color(0xFFFFB300), size: 18), label: Text('Ulasan sudah dikirim'))
          else
            PrimaryButton('Beri Rating & Ulasan', () async {
              final result = await Navigator.push<bool>(context, MaterialPageRoute(builder: (_) => const RenterReviewPage(productTitle: 'Kebaya Jawa', shopName: 'Toko Sari Budaya')));
              if (result == true && mounted) setState(() => demoReviewed = true);
            }),
          const SizedBox(height: 8),
          const Text('Pesanan ini adalah contoh demo agar alur rating dapat dicoba. Data belum disimpan ke database.', style: TextStyle(fontSize: 11, color: Color(0xFF78695D))),
        ]),
      ),
      const SizedBox(height: 16),
      const Text('Status pesanan yang akan digunakan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const _StatusRow(color: terracotta, title: 'Menunggu pembayaran', detail: 'Penyewa menyelesaikan pembayaran.'),
      const _StatusRow(color: zaitun, title: 'Menunggu konfirmasi', detail: 'Pemilik memeriksa permintaan sewa.'),
      const _StatusRow(color: Colors.blueGrey, title: 'Dikonfirmasi', detail: 'Pesanan disetujui dan jadwal dikunci.'),
      const _StatusRow(color: zaitun, title: 'Selesai', detail: 'Setelah sewa selesai, penyewa dapat memberi rating dan ulasan.'),
      const _StatusRow(color: Colors.redAccent, title: 'Dibatalkan / sengketa', detail: 'Pesanan dibatalkan atau sedang ditinjau.'),
    ]),
  );
}

class RenterReviewPage extends StatefulWidget {
  final String productTitle;
  final String shopName;
  const RenterReviewPage({super.key, required this.productTitle, required this.shopName});
  @override
  State<RenterReviewPage> createState() => _RenterReviewPageState();
}

class _RenterReviewPageState extends State<RenterReviewPage> {
  int rating = 5;
  final commentController = TextEditingController();
  bool recommend = true;

  @override
  void dispose() { commentController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Rating & Ulasan')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Bagaimana pengalaman sewamu?', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 6),
      Text('${widget.productTitle} · ${widget.shopName}', style: const TextStyle(color: Color(0xFF78695D))),
      const SizedBox(height: 24),
      Center(child: Wrap(spacing: 6, children: List.generate(5, (index) => IconButton(
        onPressed: () => setState(() => rating = index + 1),
        icon: Icon(index < rating ? Icons.star_rounded : Icons.star_outline_rounded, size: 38, color: const Color(0xFFFFB300)),
        tooltip: '${index + 1} bintang',
      )))),
      Center(child: Text(['', 'Kurang puas', 'Cukup', 'Baik', 'Puas', 'Sangat puas'][rating], style: const TextStyle(fontWeight: FontWeight.w800, color: kayu, fontSize: 16))),
      const SizedBox(height: 22),
      TextField(controller: commentController, minLines: 4, maxLines: 6, maxLength: 500, decoration: const InputDecoration(labelText: 'Tulis ulasan', hintText: 'Ceritakan kondisi barang, proses sewa, dan pengalamanmu...', alignLabelWithHint: true)),
      const SizedBox(height: 8),
      SwitchListTile(contentPadding: EdgeInsets.zero, activeThumbColor: kayu, title: const Text('Saya merekomendasikan toko ini'), value: recommend, onChanged: (v) => setState(() => recommend = v)),
      const SizedBox(height: 18),
      PrimaryButton('Kirim Ulasan', () {
        final comment = commentController.text.trim();
        if (comment.isEmpty) { notice(context, 'Tulis komentar terlebih dahulu.'); return; }
        ragamNusaReviews.insert(0, {
          'name': 'Penyewa Demo',
          'product': widget.productTitle,
          'date': 'Hari ini',
          'rating': rating,
          'comment': '$comment${recommend ? '\n\nSaya merekomendasikan toko ini.' : ''}',
          'reply': '',
        });
        notice(context, 'Ulasan demo berhasil dikirim dan akan terlihat di halaman pemilik.');
        Navigator.pop(context, true);
      }),
      const SizedBox(height: 10),
      const Text('Mode prototype: ulasan hanya tersimpan sementara di memori aplikasi. Untuk menyimpan permanen dan menghubungkan akun penyewa-pemilik, diperlukan database/backend.', style: TextStyle(fontSize: 11, height: 1.5, color: Color(0xFF78695D))),
    ]),
  );
}

class _StatusRow extends StatelessWidget {
  final Color color; final String title, detail;
  const _StatusRow({required this.color, required this.title, required this.detail});
  @override
  Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(radius: 6, backgroundColor: color), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(detail));
}

class HelpDisputePage extends StatefulWidget {
  const HelpDisputePage({super.key});
  @override
  State<HelpDisputePage> createState() => _HelpDisputePageState();
}
class _HelpDisputePageState extends State<HelpDisputePage> {
  final subject = TextEditingController();
  final detail = TextEditingController();
  String party = 'Saya penyewa';
  String type = 'Deposit ditahan tanpa bukti';
  @override
  void dispose() { subject.dispose(); detail.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Bantuan & Sengketa')), body: ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Bantuan & penyelesaian sengketa', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
    const SizedBox(height: 6), const Text('Kedua pihak memiliki hak dan kewajiban. Laporan diperiksa berdasarkan bukti, bukan otomatis memenangkan salah satu pihak.'),
    const SizedBox(height: 18),
    _surface(const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Jika pemilik merugikan penyewa', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), SizedBox(height: 8),
      Text('Contoh: deposit dipotong tanpa bukti, barang yang dijanjikan tidak tersedia, atau refund yang disetujui tidak diberikan.'), SizedBox(height: 6),
      Text('Kemungkinan konsekuensi setelah pemeriksaan: pengembalian deposit/refund, kompensasi sesuai kebijakan, peringatan, pembatasan akun, atau penangguhan toko untuk pelanggaran berulang.'),
      Divider(height: 24),
      Text('Jika penyewa merugikan pemilik', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), SizedBox(height: 8),
      Text('Contoh: barang hilang/rusak, terlambat mengembalikan, atau memberikan bukti pembayaran palsu.'), SizedBox(height: 6),
      Text('Kemungkinan konsekuensi setelah pemeriksaan: biaya perbaikan/penggantian yang terbukti, pemotongan deposit secara proporsional, peringatan, pembatasan akun, atau penangguhan akun untuk pelanggaran berulang.'),
      Divider(height: 24),
      Text('Prinsip keadilan', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)), SizedBox(height: 8),
      Text('Kedua pihak dapat mengirim bukti, melihat alasan keputusan, dan mengajukan banding. Deposit tidak boleh otomatis hangus; nilai potongan harus didukung bukti dan proses peninjauan.'),
    ])),
    const SizedBox(height: 20), const Text('Ajukan laporan sengketa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 10), DropdownButtonFormField<String>(initialValue: party, decoration: const InputDecoration(labelText: 'Saya melapor sebagai'), items: const ['Saya penyewa', 'Saya pemilik toko'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() { party = v ?? party; type = party == 'Saya penyewa' ? 'Deposit ditahan tanpa bukti' : 'Barang rusak atau hilang'; })),
    const SizedBox(height: 12), DropdownButtonFormField<String>(key: ValueKey(party), initialValue: type, decoration: const InputDecoration(labelText: 'Jenis sengketa'), items: (party == 'Saya penyewa' ? ['Deposit ditahan tanpa bukti', 'Barang tidak sesuai', 'Refund tidak diberikan', 'Pesanan dibatalkan sepihak', 'Pemilik tidak mengirim barang', 'Lainnya'] : ['Barang rusak atau hilang', 'Penyewa terlambat mengembalikan', 'Bukti pembayaran bermasalah', 'Kerugian biaya perbaikan', 'Pelanggaran ketentuan sewa', 'Lainnya']).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => type = v ?? type)),
    const SizedBox(height: 12), TextField(controller: subject, decoration: const InputDecoration(labelText: 'Judul laporan', hintText: 'Contoh: deposit dipotong sepihak')),
    const SizedBox(height: 12), TextField(controller: detail, minLines: 4, maxLines: 6, decoration: const InputDecoration(labelText: 'Kronologi dan bukti yang tersedia', alignLabelWithHint: true)),
    const SizedBox(height: 16),
    PrimaryButton('Kirim Laporan Demo', () {
      if (subject.text.trim().isEmpty || detail.text.trim().isEmpty) { notice(context, 'Isi judul dan kronologi laporan terlebih dahulu.'); return; }
      showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(title: const Text('Laporan siap ditinjau (demo)'), content: Text('Pelapor: $party\nJenis: $type\nJudul: ${subject.text.trim()}\n\nDalam aplikasi nyata, kedua pihak harus dapat mengunggah bukti dan memberi tanggapan. Keputusan serta konsekuensi tidak boleh otomatis diterapkan tanpa pemeriksaan.'), actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Tutup'))]));
    }),
    const SizedBox(height: 8), const Text('Prototype ini belum mengirim laporan ke server atau menerapkan sanksi nyata.', style: TextStyle(fontSize: 12, color: Color(0xFF78695D))),
  ]));
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage> {
  bool orderNotifications = true, chatNotifications = true, promoNotifications = false, privateProfile = false;
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Pengaturan')), body: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Preferensi aplikasi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
    const SizedBox(height: 12),
    _surface(Column(children: [
      SwitchListTile(value: orderNotifications, activeThumbColor: kayu, title: const Text('Notifikasi pesanan'), subtitle: const Text('Pembaruan status sewa dan pembayaran'), onChanged: (v) => setState(() => orderNotifications = v)),
      SwitchListTile(value: chatNotifications, activeThumbColor: kayu, title: const Text('Notifikasi chat'), subtitle: const Text('Pesan dari penyewa atau pemilik'), onChanged: (v) => setState(() => chatNotifications = v)),
      SwitchListTile(value: promoNotifications, activeThumbColor: kayu, title: const Text('Info dan promo'), subtitle: const Text('Berita dan informasi RAGAMNUSA'), onChanged: (v) => setState(() => promoNotifications = v)),
    ])),
    const SizedBox(height: 16), const Text('Privasi dan tampilan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
    const SizedBox(height: 10),
    _surface(Column(children: [
      SwitchListTile(value: privateProfile, activeThumbColor: kayu, title: const Text('Batasi tampilan profil'), subtitle: const Text('Preferensi demo; belum mengubah data server'), onChanged: (v) => setState(() => privateProfile = v)),
      ListTile(leading: const Icon(Icons.lock_outline, color: kayu), title: const Text('Kata sandi dan keamanan'), subtitle: const Text('Penggantian kata sandi perlu autentikasi backend'), onTap: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Keamanan akun'), content: const Text('Fitur ubah kata sandi akan aktif setelah autentikasi backend dihubungkan.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Mengerti'))]))),
      ListTile(leading: const Icon(Icons.description_outlined, color: kayu), title: const Text('Ketentuan & kebijakan privasi'), trailing: const Icon(Icons.chevron_right), onTap: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Ketentuan RAGAMNUSA'), content: const Text('Gunakan data yang benar, hormati ketentuan pemilik, dan simpan bukti komunikasi serta pembayaran. Kebijakan resmi perlu disiapkan sebelum aplikasi dirilis.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))]))),
    ])),
    const SizedBox(height: 18), PrimaryButton('Simpan preferensi demo', () => notice(context, 'Preferensi aktif selama halaman ini terbuka. Penyimpanan permanen perlu ditambahkan.')),
  ]));
}


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email = TextEditingController();
  @override void dispose() { email.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Lupa Kata Sandi')), body: ListView(padding: const EdgeInsets.all(24), children: [
    const Icon(Icons.lock_reset_outlined, size: 70, color: kayu), const SizedBox(height: 16),
    const Text('Reset kata sandi', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8), const Text('Masukkan email akunmu. Pada prototype, ini hanya simulasi; pengiriman tautan reset perlu backend/email service.'),
    const SizedBox(height: 18), TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
    const SizedBox(height: 18), PrimaryButton('Kirim tautan reset', () { if (!email.text.contains('@')) { notice(context, 'Masukkan email yang valid.'); return; } showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Simulasi reset'), content: Text('Jika ${email.text.trim()} terdaftar, instruksi reset akan dikirim setelah backend diaktifkan.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Mengerti'))])); }),
    const SizedBox(height: 8), PrimaryButton('Kembali ke Login', () => Navigator.pop(context), outline: true),
  ]));
}

class HandoverPage extends StatefulWidget {
  final String productTitle; final int deposit;
  const HandoverPage({super.key, required this.productTitle, required this.deposit});
  @override State<HandoverPage> createState() => _HandoverPageState();
}
class _HandoverPageState extends State<HandoverPage> {
  final notes = TextEditingController();
  String condition = 'Baik / tidak ada kerusakan';
  String damage = 'Noda';
  bool ownerConfirmed = false, renterConfirmed = false;
  final damageCost = TextEditingController(text: '0');
  @override void dispose() { notes.dispose(); damageCost.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    final cost = int.tryParse(damageCost.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final deduction = condition == 'Ada kerusakan' ? cost.clamp(0, widget.deposit) : 0;
    final refund = widget.deposit - deduction;
    return Scaffold(appBar: AppBar(title: const Text('Serah Terima & Pengembalian')), body: ListView(padding: const EdgeInsets.all(20), children: [
      Text(widget.productTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)), const SizedBox(height: 6),
      const Text('Isi kondisi barang saat pengembalian. Foto bukti dapat ditambahkan setelah fitur unggah dihubungkan.'), const SizedBox(height: 16),
      DropdownButtonFormField<String>(initialValue: condition, isExpanded: true, decoration: const InputDecoration(labelText: 'Kondisi barang'), items: const ['Baik / tidak ada kerusakan', 'Ada kerusakan'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() { condition = v ?? condition; if (condition != 'Ada kerusakan') damageCost.text = '0'; })),
      if (condition == 'Ada kerusakan') ...[
        const SizedBox(height: 12), DropdownButtonFormField<String>(key: const ValueKey('damage-type-dropdown'), initialValue: damage, isExpanded: true, decoration: const InputDecoration(labelText: 'Jenis kerusakan'), items: const ['Noda', 'Noda membandel', 'Sobek', 'Berlubang', 'Jahitan lepas', 'Bagian/aksesori hilang', 'Patah atau retak', 'Warna luntur', 'Kerusakan lainnya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => damage = v ?? damage)),
        const SizedBox(height: 12), TextField(controller: damageCost, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Estimasi biaya berdasarkan bukti (Rp)'), onChanged: (_) => setState(() {})),
      ],
      const SizedBox(height: 12), TextField(controller: notes, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: 'Catatan kondisi / bukti', hintText: 'Jelaskan kondisi barang secara jujur')),
      const SizedBox(height: 14), CheckboxListTile(value: ownerConfirmed, onChanged: (v) => setState(() => ownerConfirmed = v ?? false), activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Konfirmasi pemilik')), 
      CheckboxListTile(value: renterConfirmed, onChanged: (v) => setState(() => renterConfirmed = v ?? false), activeColor: kayu, contentPadding: EdgeInsets.zero, title: const Text('Konfirmasi penyewa')),
      _surface(Column(children: [_summaryRow('Deposit awal', _rupiah(widget.deposit)), _summaryRow('Potongan kerusakan', _rupiah(deduction)), const Divider(), _summaryRow('Deposit dikembalikan', _rupiah(refund), bold: true)])),
      const SizedBox(height: 8), const Text('Pembatalan tidak memotong deposit. Potongan hanya untuk kerusakan yang terbukti dan dapat disengketakan. Nilai di atas simulasi.'), const SizedBox(height: 16),
      PrimaryButton('Simpan Serah Terima Demo', () { if (!ownerConfirmed || !renterConfirmed) { notice(context, 'Kedua pihak perlu konfirmasi.'); return; } if (condition == 'Ada kerusakan' && notes.text.trim().isEmpty) { notice(context, 'Jelaskan kerusakan dan bukti terlebih dahulu.'); return; } showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Serah terima dicatat (demo)'), content: Text('Potongan tercatat: ${_rupiah(deduction)}\nPengembalian: ${_rupiah(refund)}\n\nData belum tersimpan ke server. Dalam penggunaan nyata, konfirmasi kedua pihak harus dilakukan dari akun masing-masing.'), actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('Selesai'))])); }),
    ]));
  }
}

Widget _surface(Widget child) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: kayu.withValues(alpha: .10))), child: child);
Widget _summaryRow(String label, String value, {bool bold = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Text(label, style: TextStyle(color: teks.withValues(alpha: .72)))), const SizedBox(width: 12), Flexible(child: Text(value, textAlign: TextAlign.end, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w600, color: bold ? kayu : teks)))]));
String _dateLabel(DateTime d) => '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

class PlaceholderPage extends StatelessWidget {
  final String title, description;
  final IconData icon;
  const PlaceholderPage({super.key, required this.title, required this.description, required this.icon});
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: terracotta.withValues(alpha: .13), borderRadius: BorderRadius.circular(22)),
              child: Icon(icon, color: kayu, size: 45),
            ),
            const SizedBox(height: 17),
            Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: teks.withValues(alpha: .7), height: 1.5), textAlign: TextAlign.center),
          ]),
        ),
      );
}