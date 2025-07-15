import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_page.dart';
import 'service_page.dart';
import 'main.dart'; // Import HomePage

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  final String facebookUrl = 'https://web.facebook.com/mariya.malis.75';
  final String telegramUrl = 'https://t.me/moni_pech2';
  final String phoneNumber = 'tel:+85515992803';

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String label,
    Widget targetPage, {
    bool isActive = false,
  }) {
    return TextButton(
      onPressed: () {
        if (!isActive) {
          _navigate(context, targetPage);
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.cyanAccent : Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white, width: 1.5)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF063970),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildNavButton(context, 'Home', const HomePage()),
            _buildNavButton(context, 'About', const AboutPage()),
            _buildNavButton(context, 'Skills', const ServicePage()),
            _buildNavButton(
              context,
              'Contact',
              const ContactPage(),
              isActive: true,
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Center(
            // <-- Center everything vertically and horizontally
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CONTACT',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Get In Touch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.blue[900]!.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.cyanAccent.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildContactRow(
                          icon: Icons.facebook,
                          label: 'Ket Malismonipech',
                          onTap: () => _launchUrl(facebookUrl),
                        ),
                        const SizedBox(height: 30),
                        _buildContactRow(
                          icon: Icons.send,
                          label: 'Ket Malismonipech',
                          onTap: () => _launchUrl(telegramUrl),
                        ),
                        const SizedBox(height: 30),
                        _buildContactRow(
                          icon: Icons.phone,
                          label: '015 992 803',
                          onTap: () => _launchUrl(phoneNumber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
