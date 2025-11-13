import 'package:flutter/material.dart';

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> with SingleTickerProviderStateMixin {
  String lokasi = "Bandung, Indonesia";
  String kondisi = "Cerah";
  String suhu = "30°C";
  String kelembapan = "68%";
  String tekanan = "1012 hPa";
  String kecepatanAngin = "12 km/h";

  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  final List<Map<String, String>> prakiraan = [
    {"hari": "Senin", "kondisi": "Cerah", "suhu": "31°C"},
    {"hari": "Selasa", "kondisi": "Mendung", "suhu": "28°C"},
    {"hari": "Rabu", "kondisi": "Hujan", "suhu": "26°C"},
    {"hari": "Kamis", "kondisi": "Cerah", "suhu": "30°C"},
    {"hari": "Jumat", "kondisi": "Cerah", "suhu": "32°C"},
    {"hari": "Sabtu", "kondisi": "Hujan", "suhu": "25°C"},
    {"hari": "Minggu", "kondisi": "Mendung", "suhu": "27°C"},
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(_fadeIn);
    _controller.forward();
  }

  Map<String, dynamic> getCuacaTheme() {
    switch (kondisi) {
      case "Cerah":
        return {
          "warnaAtas": const Color(0xFF9BE8FF),
          "warnaBawah": const Color(0xFFE9F8FF),
          "ikon": Icons.wb_sunny,
          "warnaIkon": Colors.orangeAccent,
          "deskripsi": "Langit cerah dan bersinar ☀️",
        };
      case "Mendung":
        return {
          "warnaAtas": Colors.blueGrey.shade400,
          "warnaBawah": Colors.grey.shade100,
          "ikon": Icons.cloud,
          "warnaIkon": Colors.grey.shade800,
          "deskripsi": "Langit mendung tertutup awan ☁️",
        };
      case "Hujan":
        return {
          "warnaAtas": Colors.indigo.shade600,
          "warnaBawah": Colors.indigo.shade100,
          "ikon": Icons.thunderstorm,
          "warnaIkon": Colors.yellowAccent,
          "deskripsi": "Hujan deras disertai petir ⛈️",
        };
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = getCuacaTheme();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [data["warnaAtas"], data["warnaBawah"]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideUp,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // Lokasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          lokasi,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Kartu utama kondisi saat ini
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(data["ikon"], color: data["warnaIkon"], size: 100),
                          const SizedBox(height: 10),
                          Text(
                            suhu,
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            kondisi,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data["deskripsi"],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _InfoItem(icon: Icons.air, label: kecepatanAngin),
                              _InfoItem(icon: Icons.water_drop, label: kelembapan),
                              _InfoItem(icon: Icons.thermostat, label: tekanan),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // Judul prakiraan
                    const Text(
                      "Prakiraan 7 Hari ke Depan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Daftar prakiraan (horizontal)
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prakiraan.length,
                        itemBuilder: (context, index) {
                          final p = prakiraan[index];
                          final icon = p["kondisi"] == "Cerah"
                              ? Icons.wb_sunny
                              : p["kondisi"] == "Mendung"
                                  ? Icons.cloud
                                  : Icons.thunderstorm;
                          final warna = p["kondisi"] == "Cerah"
                              ? Colors.orangeAccent
                              : p["kondisi"] == "Mendung"
                                  ? Colors.grey
                                  : Colors.indigoAccent;

                          return Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  p["hari"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Icon(icon, color: warna, size: 38),
                                const SizedBox(height: 8),
                                Text(
                                  p["suhu"]!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  p["kondisi"]!,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 50),

                    Text(
                      "Data cuaca masih bersifat dummy (belum terhubung API)",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40), // tidak akan terpotong
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueGrey, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}
