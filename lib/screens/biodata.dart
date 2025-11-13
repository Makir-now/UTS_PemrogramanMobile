import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameCtrl =
      TextEditingController(text: 'Ujang Ismail');
  final TextEditingController _nimCtrl =
      TextEditingController(text: '152023184');
  final TextEditingController _addressCtrl =
      TextEditingController(text: 'Bandung');
  final TextEditingController _cityCtrl =
      TextEditingController(text: 'Bandung');

  String _gender = 'Laki-laki';
  DateTime? _selectedDate;
  File? _pickedImage;

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _pickedImage = File(picked.path));
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(now.year - 20),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Putih elegan
      body: FadeTransition(
        opacity: _fadeIn,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 20),

            // 📸 Foto Profil
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : const AssetImage(
                                    'assets/images/152023184_Ujang Ismail.jpg')
                                as ImageProvider,
                      ),
                      IconButton(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _nameCtrl.text,
                    style: const TextStyle(
                      color: Color(0xFF1A1C1E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _nimCtrl.text,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 📋 Form Inputs
            _modernCard(
              icon: Icons.person_outline,
              child: TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
            _modernCard(
              icon: Icons.badge_outlined,
              child: TextField(
                controller: _nimCtrl,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
            _modernCard(
              icon: Icons.home_outlined,
              child: TextField(
                controller: _addressCtrl,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
            _modernCard(
              icon: Icons.location_city_outlined,
              child: TextField(
                controller: _cityCtrl,
                decoration: const InputDecoration(
                  labelText: 'Kota Asal',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),

            // 🚻 Jenis Kelamin
            _modernCard(
              icon: Icons.wc_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jenis Kelamin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 15)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Laki-laki',
                              style: TextStyle(color: Colors.black87)),
                          value: 'Laki-laki',
                          groupValue: _gender,
                          activeColor: Colors.blueAccent,
                          onChanged: (v) =>
                              setState(() => _gender = v ?? _gender),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Perempuan',
                              style: TextStyle(color: Colors.black87)),
                          value: 'Perempuan',
                          groupValue: _gender,
                          activeColor: Colors.blueAccent,
                          onChanged: (v) =>
                              setState(() => _gender = v ?? _gender),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 📅 Tanggal Lahir
            _modernCard(
              icon: Icons.calendar_today_outlined,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tanggal Lahir',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                subtitle: Text(
                  _selectedDate == null
                      ? 'Belum dipilih'
                      : _selectedDate!.toLocal().toString().split(' ')[0],
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: ElevatedButton(
                  onPressed: _pickDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Pilih'),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 💾 Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Data tidak disimpan (sifat tugas: statis, tampilan modern 💎)')),
                  );
                },
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan (statis)',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  shadowColor: Colors.blueAccent.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernCard({required IconData icon, required Widget child}) {
    return Card(
      elevation: 3,
      shadowColor: Colors.blueAccent.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 26),
            const SizedBox(width: 12),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
