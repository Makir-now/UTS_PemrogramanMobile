import 'package:flutter/material.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final contacts = List.generate(15, (i) {
    final names = [
      'Andi', 'Budi', 'Citra', 'Dewi', 'Eko', 'Farah', 'Galih', 'Hani',
      'Ibrahim', 'Joko', 'Kevin', 'Lina', 'Maya', 'Nina', 'Oki'
    ];
    return {
      'name': names[i],
      'phone': '0812-34${(1000 + i).toString().padLeft(4, '0')}',
    };
  });

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
      backgroundColor: const Color(0xFFF5F7FA), // putih elegan
      body: FadeTransition(
        opacity: _fadeIn,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final c = contacts[index];
            return _buildContactCard(c['name']!, c['phone']!, index);
          },
        ),
      ),
    );
  }

  Widget _buildContactCard(String name, String phone, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 80)),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.blueAccent.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.shade200,
                    Colors.lightBlueAccent.shade100
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1C1E)),
          ),
          subtitle: Text(
            phone,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.call, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}