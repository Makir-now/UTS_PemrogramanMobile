import 'package:flutter/material.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  final List<Map<String, String>> beritaList = [
    {
      "judul": "Timnas Indonesia Menang 3-0 atas Malaysia",
      "sumber": "ESPN Indonesia",
      "tanggal": "2025-11-13",
      "gambar": "assets/images/berita1.png",
    },
    {
      "judul": "Kasus Pembunuhan di Bandung Berhasil Diungkap Polisi",
      "sumber": "Kompas",
      "tanggal": "2025-11-12",
      "gambar": "assets/images/berita2.png",
    },
    {
      "judul": "IHSG Naik 2% Karena Investasi Asing Masuk Deras",
      "sumber": "CNBC Indonesia",
      "tanggal": "2025-11-11",
      "gambar": "assets/images/berita3.png",
    },
    {
      "judul": "Apple Rilis iPhone 17 dengan Teknologi AI Baru",
      "sumber": "The Verge",
      "tanggal": "2025-11-10",
      "gambar": "assets/images/berita4.png",
    },
    {
      "judul": "Liverpool Raih Kemenangan Dramatis di Liga Champions",
      "sumber": "BBC Sport",
      "tanggal": "2025-11-09",
      "gambar": "assets/images/berita5.png",
    },
    {
      "judul": "Kasus Korupsi Dana Proyek Jalan Ditangani KPK",
      "sumber": "Detik News",
      "tanggal": "2025-11-08",
      "gambar": "assets/images/berita6.png",
    },
    {
      "judul": "Investor Asing Tertarik dengan Startup Indonesia",
      "sumber": "Reuters",
      "tanggal": "2025-11-07",
      "gambar": "assets/images/berita7.png",
    },
    {
      "judul": "Film Baru Marvel Raup Rp 1 Triliun di Minggu Pertama",
      "sumber": "CNN Entertainment",
      "tanggal": "2025-11-06",
      "gambar": "assets/images/berita8.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _slideUp,
            child: ListView.builder(
              itemCount: beritaList.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final berita = beritaList[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🖼️ Gambar berita dengan overlay gradasi
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Stack(
                          children: [
                            Image.asset(
                              berita["gambar"]!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.05),
                                    Colors.black.withOpacity(0.4),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 📰 Informasi berita
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              berita["judul"]!,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Row sumber + tanggal dengan tag
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    berita["sumber"]!,
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(
                                      berita["tanggal"]!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
