import 'package:flutter/material.dart';
import 'about_page.dart';
import 'contact_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_fadeAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF063970),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(), // No back button
        title: Row(
          children: [
            const Spacer(),
            _buildNavButton(context, 'Home'),
            _buildNavButton(context, 'About'),
            _buildNavButton(context, 'Skills'),
            _buildNavButton(context, 'Contact'),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'MY SKILLS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 40),
                _buildExpertiseSection(
                  icon: Icons.code,
                  title: 'Programming',
                  items: const [
                    'Programming Languages: Advanced Python, Java',
                    'Web & App Frameworks: Laravel (PHP), Flutter (Dart)',
                  ],
                ),
                const SizedBox(height: 40),
                _buildExpertiseSection(
                  icon: Icons.design_services,
                  title: 'Design',
                  items: const ['Figma (Basic)'],
                ),
                const SizedBox(height: 40),
                _buildExpertiseSection(
                  icon: Icons.storage,
                  title: 'Database',
                  items: const [
                    'Database Management: SQL, MySQL Server, PostgreSQL',
                    'Backend & Cloud: Firebase (Authentication, Realtime DB / Firestore)',
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpertiseSection({
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[900]!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.cyanAccent, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, right: 10),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text) {
    return TextButton(
      onPressed: () {
        if (text == 'Home') {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (text == 'About') {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => const AboutPage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        } else if (text == 'Contact') {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => const ContactPage(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: (text == 'Skills') ? Colors.cyanAccent : Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
