import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const RagamNusaApp());

const kayu = Color(0xFF6B422D);
const gading = Color(0xFFF8F3E9);
const terracotta = Color(0xFFA66A43);
const zaitun = Color(0xFF78805B);
const teks = Color(0xFF302820);

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
      ProfilePage(name: widget.userName, role: 'Penyewa'),
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
      Text('Halo, $name 👋', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
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
        crossAxisCount: 4, shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: .82,
        children: const [
          _CategoryTile('Pakaian\nAdat', Icons.checkroom_outlined),
          _CategoryTile('Kostum\nTari', Icons.theater_comedy_outlined),
          _CategoryTile('Kerajinan', Icons.spa_outlined),
          _CategoryTile('Alat\nMusik', Icons.music_note_outlined),
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
            _ProductMiniCard(title: 'Kebaya Jawa', category: 'Pakaian adat', price: 'Rp150.000', location: 'Yogyakarta', imageUrl: 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=600'),
            SizedBox(width: 12),
            _ProductMiniCard(title: 'Kain Tenun', category: 'Kain tradisional', price: 'Rp100.000', location: 'Bali', imageUrl: 'https://images.unsplash.com/photo-1604881988758-f76ad2f7aac1?w=600'),
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

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String category = 'Semua';
  final categories = const ['Semua', 'Pakaian Adat', 'Kostum Tari', 'Kerajinan', 'Kain Tradisional', 'Alat Musik'];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const Text('Jelajahi', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: teks)),
      const SizedBox(height: 14),
      TextField(decoration: InputDecoration(hintText: 'Cari kategori atau produk...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
      const SizedBox(height: 14),
      SizedBox(height: 40, child: ListView(scrollDirection: Axis.horizontal, children: categories.map((c) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(label: Text(c), selected: category == c, selectedColor: const Color(0xFFE6D4C0), onSelected: (_) => setState(() => category = c)),
      )).toList())),
      const SizedBox(height: 10),
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12, mainAxisSpacing: 14, childAspectRatio: .67,
        children: const [
          _ExploreProduct(title: 'Kebaya Jawa', category: 'Pakaian Adat', price: 'Rp150.000', location: 'Yogyakarta', imageUrl: 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=600'),
          _ExploreProduct(title: 'Kain Tenun Bali', category: 'Kain Tradisional', price: 'Rp100.000', location: 'Bali', imageUrl: 'https://images.unsplash.com/photo-1604881988758-f76ad2f7aac1?w=600'),
          _ExploreProduct(title: 'Kostum Tari', category: 'Kostum Tari', price: 'Rp125.000', location: 'Surabaya', imageUrl: 'https://images.unsplash.com/photo-1531058020387-3be344556be6?w=600'),
          _ExploreProduct(title: 'Aksesori Tradisional', category: 'Kerajinan', price: 'Rp50.000', location: 'Malang', imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=600'),
        ],
      ),
    ],
  );
}

class _ExploreProduct extends StatelessWidget {
  final String title, category, price, location, imageUrl;
  const _ExploreProduct({required this.title, required this.category, required this.price, required this.location, required this.imageUrl});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(title: title, category: category, price: price, location: location, imageUrl: imageUrl))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFFE8D9C7), child: const Center(child: Icon(Icons.image_outlined, size: 45, color: kayu)))))),
      const SizedBox(height: 8),
      Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, color: teks)),
      Text(category, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
      Text('$price/hari', style: const TextStyle(fontWeight: FontWeight.bold, color: kayu)),
      Row(children: [const Icon(Icons.location_on_outlined, size: 13, color: terracotta), Expanded(child: Text(location, style: const TextStyle(fontSize: 11, color: teks)))]),
    ]),
  );
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
      const SizedBox(height: 22),
      PrimaryButton('Pilih Tanggal Sewa', () => Navigator.push(context, MaterialPageRoute(builder: (_) => RentalCalendarPage(title: title, price: price)))),
      const SizedBox(height: 10),
      PrimaryButton('Chat Pemilik', () => notice(context, 'Fitur chat akan dihubungkan pada tahap berikutnya.'), outline: true),
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

class OwnerHomePage extends StatefulWidget {
  final String ownerName, shopName;
  const OwnerHomePage({super.key, required this.ownerName, required this.shopName});
  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      OwnerDashboard(name: widget.ownerName, shop: widget.shopName),
      const PlaceholderPage(title: 'Produk Saya', description: 'Kelola produk budaya yang disewakan.', icon: Icons.inventory_2_outlined),
      const PlaceholderPage(title: 'Pesanan Masuk', description: 'Pesanan dari penyewa akan tampil di sini.', icon: Icons.receipt_long_outlined),
      ProfilePage(name: widget.ownerName, role: 'Pemilik Toko'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('RAGAMNUSA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1))),
      body: pages[tab],
      floatingActionButton: tab == 1 ? FloatingActionButton.extended(
        backgroundColor: kayu, foregroundColor: Colors.white,
        onPressed: () => notice(context, 'Form tambah produk akan dibuat pada tahap berikutnya.'),
        icon: const Icon(Icons.add), label: const Text('Tambah produk'),
      ) : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Produk'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Pesanan'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class OwnerDashboard extends StatelessWidget {
  final String name, shop;
  const OwnerDashboard({super.key, required this.name, required this.shop});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Halo, $name 👋', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          Text(shop, style: TextStyle(color: teks.withValues(alpha: .7))),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: kayu, borderRadius: BorderRadius.circular(20)),
            child: const Text('Dashboard Toko\nKelola persewaan produk budaya kamu.',
                style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800, height: 1.4)),
          ),
          const SizedBox(height: 22),
          const Text('Ringkasan toko', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          const Row(children: [
            Expanded(child: StatCard(icon: Icons.inventory_2_outlined, label: 'Produk aktif')),
            SizedBox(width: 12),
            Expanded(child: StatCard(icon: Icons.receipt_long_outlined, label: 'Pesanan baru')),
          ]),
          const SizedBox(height: 12),
          const Row(children: [
            Expanded(child: StatCard(icon: Icons.calendar_month_outlined, label: 'Jadwal sewa')),
            SizedBox(width: 12),
            Expanded(child: StatCard(icon: Icons.star_border_rounded, label: 'Ulasan')),
          ]),
          const SizedBox(height: 20),
          const Text('Angka masih contoh untuk tampilan demo.', style: TextStyle(fontSize: 12, color: teks)),
        ],
      );
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const StatCard({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: kayu.withValues(alpha: .13))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: terracotta, size: 25),
          const SizedBox(height: 10),
          const Text('0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label, style: TextStyle(fontSize: 12, color: teks.withValues(alpha: .7))),
        ]),
      );
}

class ProfilePage extends StatelessWidget {
  final String name, role;
  const ProfilePage({super.key, required this.name, required this.role});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Row(children: [
              const CircleAvatar(radius: 27, backgroundColor: Color(0xFFE8D9C7), child: Icon(Icons.person, color: kayu, size: 30)),
              const SizedBox(width: 13),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 4),
                Text(role, style: const TextStyle(color: terracotta)),
              ])),
            ]),
          ),
          const SizedBox(height: 15),
          ListTile(leading: const Icon(Icons.badge_outlined, color: kayu), title: const Text('Data identitas'), trailing: const Icon(Icons.chevron_right), onTap: () => notice(context, 'Pengelolaan identitas perlu backend.')),
          ListTile(leading: const Icon(Icons.chat_bubble_outline, color: kayu), title: const Text('Pusat bantuan & sengketa'), subtitle: const Text('FAQ, laporkan masalah, ajukan sengketa'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpDisputePage()))),
          ListTile(leading: const Icon(Icons.settings_outlined, color: kayu), title: const Text('Pengaturan'), subtitle: const Text('Notifikasi, privasi, dan tampilan'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()))),
          const SizedBox(height: 15),
          PrimaryButton('Keluar ke Login', () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false,
          ), outline: true),
        ],
      );
}


int _parsePrice(String value) {
  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
  return int.tryParse(digits) ?? 75000;
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
        const Text('Pilih pengiriman / kurir', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(value: courier, isExpanded: true, decoration: const InputDecoration(labelText: 'Layanan kurir'), items: couriers.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(), onChanged: (v) => setState(() => courier = v ?? courier)),
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

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Pesanan Saya')), body: ListView(padding: const EdgeInsets.all(18), children: [
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Belum ada pesanan tersimpan', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)), SizedBox(height: 6), Text('Pesanan dari alur pembayaran demo akan ditampilkan di sini setelah dihubungkan ke penyimpanan aplikasi/backend.'), SizedBox(height: 12), Chip(avatar: Icon(Icons.info_outline, size: 17), label: Text('Mode prototype'))])),
    const SizedBox(height: 16),
    const Text('Status pesanan yang akan digunakan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
    const SizedBox(height: 8),
    const _StatusRow(color: terracotta, title: 'Menunggu pembayaran', detail: 'Penyewa menyelesaikan pembayaran.'),
    const _StatusRow(color: zaitun, title: 'Menunggu konfirmasi', detail: 'Pemilik memeriksa permintaan sewa.'),
    const _StatusRow(color: Colors.blueGrey, title: 'Dikonfirmasi', detail: 'Pesanan disetujui dan jadwal dikunci.'),
    const _StatusRow(color: Colors.redAccent, title: 'Dibatalkan / sengketa', detail: 'Pesanan dibatalkan atau sedang ditinjau.'),
  ]));
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

class _FaqTile extends StatelessWidget {
  final String question, answer;
  const _FaqTile({required this.question, required this.answer});
  @override
  Widget build(BuildContext context) => ExpansionTile(title: Text(question, style: const TextStyle(fontWeight: FontWeight.w700)), children: [Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 14), child: Align(alignment: Alignment.centerLeft, child: Text(answer)))]);
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
      DropdownButtonFormField<String>(value: condition, isExpanded: true, decoration: const InputDecoration(labelText: 'Kondisi barang'), items: const ['Baik / tidak ada kerusakan', 'Ada kerusakan'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() { condition = v ?? condition; if (condition != 'Ada kerusakan') damageCost.text = '0'; })),
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