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
    {'name': 'Kebaya Jawa', 'category': 'Pakaian Adat', 'price': '150000', 'deposit': '100000', 'stock': '5', 'condition': 'Sangat baik', 'location': 'Yogyakarta', 'description': 'Kebaya klasik Jawa dengan detail bordir.', 'status': 'Tersedia'},
    {'name': 'Kain Tenun Bali', 'category': 'Kain Tradisional', 'price': '100000', 'deposit': '50000', 'stock': '3', 'condition': 'Baik', 'location': 'Denpasar', 'description': 'Kain tenun tradisional untuk acara adat.', 'status': 'Tersedia'},
    {'name': 'Aksesori Tradisional', 'category': 'Kerajinan', 'price': '75000', 'deposit': '25000', 'stock': '8', 'condition': 'Baik', 'location': 'Yogyakarta', 'description': 'Aksesori pelengkap busana tradisional.', 'status': 'Tersedia'},
  ];
  final List<Map<String, String>> orders = [
    {'customer': 'Sari Wulandari', 'product': 'Kebaya Jawa', 'date': '3–6 Okt 2026', 'total': '450000', 'status': 'Menunggu Konfirmasi'},
    {'customer': 'Budi Santoso', 'product': 'Kain Tenun Bali', 'date': '8–10 Okt 2026', 'total': '300000', 'status': 'Dikonfirmasi'},
    {'customer': 'Rina Kartika', 'product': 'Aksesori Tradisional', 'date': '12–14 Okt 2026', 'total': '225000', 'status': 'Sedang Disewa'},
  ];

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
              items: const ['Pakaian Adat', 'Kostum Tari', 'Kerajinan', 'Kain Tradisional', 'Alat Musik']
                .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (v) => setDialogState(() => category = v ?? category),
            ),
            const SizedBox(height: 10),
            TextField(controller: priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga sewa per hari (Rp)')),
            const SizedBox(height: 10),
            TextField(controller: stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stok')),
            const SizedBox(height: 10),
            TextField(controller: depositController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Deposit (Rp)')),
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
                if (nameController.text.trim().isEmpty || (int.tryParse(priceController.text) ?? 0) <= 0 || (int.tryParse(stockController.text) ?? 0) <= 0) {
                  notice(dialogContext, 'Isi nama, harga, dan stok dengan benar.');
                  return;
                }
                Navigator.pop(dialogContext, {
                  'name': nameController.text.trim(), 'category': category,
                  'price': priceController.text.trim(), 'stock': stockController.text.trim(),
                  'deposit': depositController.text.trim().isEmpty ? '0' : depositController.text.trim(),
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
      OwnerProductsPage(products: products, onAdd: addProduct, onChanged: () => setState(() {})),
      OwnerOrdersPage(orders: orders, onChanged: () => setState(() {})),
      const OwnerFinancePage(),
      ProfilePage(name: widget.ownerName, role: 'Pemilik Toko'),
    ];
    return Scaffold(
      backgroundColor: gading,
      appBar: AppBar(
        backgroundColor: gading, foregroundColor: kayu, elevation: 0,
        title: const Text('RAGAMNUSA', style: TextStyle(color: kayu, fontWeight: FontWeight.w900, letterSpacing: 1)),
        actions: [
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
    return ListView(padding: const EdgeInsets.fromLTRB(18, 8, 18, 24), children: [
      Text('Selamat datang, $name 👋', style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: teks)),
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
              child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('4.8', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: kayu)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.star_rounded, size: 12, color: terracotta), Icon(Icons.star_rounded, size: 12, color: terracotta), Icon(Icons.star_rounded, size: 12, color: terracotta), Icon(Icons.star_rounded, size: 12, color: terracotta), Icon(Icons.star_half_rounded, size: 12, color: terracotta)]),
              ]),
            ),
            const SizedBox(width: 13),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ulasan dari penyewa', style: TextStyle(fontWeight: FontWeight.w900, color: teks)),
              SizedBox(height: 4),
              Text('Lihat komentar, penilaian, dan tanggapi ulasan pelanggan.', style: TextStyle(fontSize: 12, height: 1.35, color: Color(0xFF78695D))),
              SizedBox(height: 6),
              Text('126 ulasan · 8 belum dibalas', style: TextStyle(fontSize: 11, color: terracotta, fontWeight: FontWeight.w800)),
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
          value: selectedProduct,
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

class OwnerProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final VoidCallback onAdd, onChanged;
  const OwnerProductsPage({super.key, required this.products, required this.onAdd, required this.onChanged});
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
          Text('Stok ${p['stock']} · ${p['status']}', style: const TextStyle(fontSize: 11, color: zaitun)),
          if ((p['condition'] ?? '').isNotEmpty) Text('Kondisi: ${p['condition']}', style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
          if ((p['deposit'] ?? '0') != '0') Text('Deposit ${_rupiah(int.tryParse(p['deposit'] ?? '') ?? 0)}', style: const TextStyle(fontSize: 11, color: terracotta)),
          if ((p['location'] ?? '').isNotEmpty) Text(p['location']!, style: const TextStyle(fontSize: 11, color: Color(0xFF78695D))),
        ])),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: kayu),
          onSelected: (v) {
            if (v == 'toggle') { p['status'] = p['status'] == 'Tersedia' ? 'Disembunyikan' : 'Tersedia'; onChanged(); }
            if (v == 'delete') { products.remove(p); onChanged(); }
          },
          itemBuilder: (_) => [
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
  final List<Map<String, dynamic>> reviews = [
    {'name': 'Sari Wulandari', 'product': 'Kebaya Jawa', 'date': '18 Okt 2026', 'rating': 5, 'comment': 'Kebayanya cantik dan bersih. Detail bordirnya bagus, pemilik juga ramah dan responsif.', 'reply': 'Terima kasih sudah menyewa di toko kami! Senang sekali kebayanya cocok untuk acara Anda.'},
    {'name': 'Budi Santoso', 'product': 'Kain Tenun Bali', 'date': '16 Okt 2026', 'rating': 5, 'comment': 'Kain sesuai foto, proses sewa mudah dan pengiriman tepat waktu.', 'reply': ''},
    {'name': 'Rina Kartika', 'product': 'Aksesori Tradisional', 'date': '14 Okt 2026', 'rating': 4, 'comment': 'Barang bagus dan terawat. Akan lebih baik kalau pilihan warna ditambah.', 'reply': ''},
    {'name': 'Dewi Anggraini', 'product': 'Kebaya Jawa', 'date': '11 Okt 2026', 'rating': 5, 'comment': 'Sangat puas! Ukuran pas dan barang dikemas dengan rapi.', 'reply': 'Terima kasih atas ulasannya, Kak Dewi. Kami tunggu pesanan berikutnya!'},
    {'name': 'Andi Pratama', 'product': 'Kain Tenun Bali', 'date': '8 Okt 2026', 'rating': 3, 'comment': 'Motifnya bagus, tetapi warna sedikit berbeda dari foto.', 'reply': ''},
  ];

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
              const Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('4.8', style: TextStyle(color: gading, fontSize: 42, height: 1, fontWeight: FontWeight.w900)), SizedBox(width: 7), Padding(padding: EdgeInsets.only(bottom: 5), child: Text('/ 5.0', style: TextStyle(color: Color(0xFFF1E5D6))))]),
              const SizedBox(height: 7),
              const Row(children: [Icon(Icons.star_rounded, color: Color(0xFFFFD27A), size: 18), Icon(Icons.star_rounded, color: Color(0xFFFFD27A), size: 18), Icon(Icons.star_rounded, color: Color(0xFFFFD27A), size: 18), Icon(Icons.star_rounded, color: Color(0xFFFFD27A), size: 18), Icon(Icons.star_half_rounded, color: Color(0xFFFFD27A), size: 18)]),
              const SizedBox(height: 5),
              const Text('Berdasarkan 126 ulasan · contoh demo', style: TextStyle(color: Color(0xFFF1E5D6), fontSize: 11)),
            ])),
            const Icon(Icons.reviews_outlined, color: Color(0x44F8F3E9), size: 82),
          ]),
        ),
        const SizedBox(height: 18),
        _surface(Column(children: [
          _ratingBar(5, 92, '73%'),
          const SizedBox(height: 10),
          _ratingBar(4, 24, '19%'),
          const SizedBox(height: 10),
          _ratingBar(3, 7, '6%'),
          const SizedBox(height: 10),
          _ratingBar(2, 2, '1.5%'),
          const SizedBox(height: 10),
          _ratingBar(1, 1, '0.5%'),
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
        const Text('Rating dan komentar pada halaman ini adalah data contoh. Nantinya data dapat diambil dari ulasan penyewa setelah transaksi selesai.', style: TextStyle(fontSize: 11, height: 1.4, color: Color(0xFF78695D))),
      ]),
    );
  }

  Widget _ratingBar(int stars, int count, String percent) => Row(children: [
    SizedBox(width: 54, child: Row(children: [Text('$stars', style: const TextStyle(fontWeight: FontWeight.w800)), const Icon(Icons.star_rounded, color: terracotta, size: 16)])),
    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: count / 126, minHeight: 8, backgroundColor: const Color(0xFFEDE2D0), color: terracotta))),
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
  late final TextEditingController nameController = TextEditingController(text: widget.shopName);
  final addressController = TextEditingController(text: 'Yogyakarta, Indonesia');
  final hoursController = TextEditingController(text: 'Senin–Sabtu, 09.00–17.00');
  final descriptionController = TextEditingController(text: 'Menyewakan busana dan perlengkapan budaya Indonesia yang terawat untuk acara adat, wisuda, dan kegiatan budaya.');
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
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.star_rounded, color: terracotta, size: 18), Text(' 4.8  ·  126 ulasan demo', style: TextStyle(color: Color(0xFF78695D), fontSize: 12))]),
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
      PrimaryButton('Simpan perubahan', () { setState(() {}); notice(context, 'Perubahan ditampilkan di prototype. Data belum tersimpan permanen.'); }),
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
        _popularProduct('Kebaya Jawa', '18 kali disewa', .86), const Divider(height: 22),
        _popularProduct('Kain Tenun Bali', '12 kali disewa', .62), const Divider(height: 22),
        _popularProduct('Aksesori Tradisional', '8 kali disewa', .42),
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

class OwnerFinancePage extends StatelessWidget {
  const OwnerFinancePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(18, 10, 18, 24), children: [
    const Text('Keuangan', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: teks)),
    const SizedBox(height: 5),
    const Text('Pantau pendapatan dan riwayat transaksi toko.', style: TextStyle(color: Color(0xFF78695D))),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF4E2F21), Color(0xFFA66A43)]), borderRadius: BorderRadius.circular(20)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Saldo tersedia · DEMO', style: TextStyle(color: gading)),
        SizedBox(height: 8),
        Text('Rp4.750.000', style: TextStyle(color: gading, fontSize: 28, fontWeight: FontWeight.w900)),
        SizedBox(height: 5),
        Text('Angka simulasi, belum terhubung ke pembayaran nyata.', style: TextStyle(color: Color(0xFFF1E5D6), fontSize: 11)),
      ]),
    ),
    const SizedBox(height: 14),
    Row(children: [
      const Expanded(child: _OwnerMetric(icon: Icons.trending_up, label: 'Pendapatan bulan ini', value: 'Rp12 jt')),
      const SizedBox(width: 10),
      const Expanded(child: _OwnerMetric(icon: Icons.hourglass_bottom, label: 'Menunggu pencairan', value: 'Rp2,1 jt')),
    ]),
    const SizedBox(height: 20),
    const Text('Riwayat transaksi', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: teks)),
    const SizedBox(height: 8),
    _surface(Column(children: [
      _summaryRow('Pembayaran sewa · Sari Wulandari', '+Rp450.000'),
      const Divider(),
      _summaryRow('Pencairan dana · Bank demo', '-Rp1.000.000'),
      const Divider(),
      _summaryRow('Pembayaran sewa · Budi Santoso', '+Rp300.000'),
      const Divider(),
      _summaryRow('Biaya layanan platform', '-Rp25.000'),
    ])),
    const SizedBox(height: 14),
    PrimaryButton('Ajukan Pencairan', () => notice(context, 'Fitur pencairan perlu integrasi rekening dan backend.')),
  ]);
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