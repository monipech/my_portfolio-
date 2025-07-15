import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'service_page.dart';
import 'contact_page.dart';
import 'main.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF063970),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(), // No back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildNavButton(context, 'Home', const HomePage()),
            _buildNavButton(
              context,
              'About',
              const AboutPage(),
              isActive: true,
            ),
            _buildNavButton(context, 'Skills', const ServicePage()),
            _buildNavButton(context, 'Contact', const ContactPage()),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'EXPERIENCE',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 20),
                _animatedContainer(
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Freelance Android Developer – IoT Control App',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Technologies: Java, Android Studio, Firebase, ESP32, Arduino',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Developed a real-time Android application to monitor and control IoT devices, including LED toggling, RC car movement, and temperature/humidity sensor data display. Integrated Firebase Realtime Database to enable seamless two-way communication between the mobile app and hardware components. Collaborated closely with a university lecturer to gather requirements and deliver a fully functional academic project, demonstrating strong problem-solving, UI design, and hardware integration skills.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'EDUCATION',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 20),
                _animatedContainer(
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EducationItem(
                        period: '2023-Present',
                        degree: 'Computer Science',
                        institution: 'Royal University of Phoenix Pach',
                      ),
                      SizedBox(height: 15),
                      EducationItem(
                        period: '2023-2024',
                        degree: 'Certificate in Core Java Programming',
                        institution: 'ETEC Center',
                      ),
                      SizedBox(height: 15),
                      EducationItem(
                        period: '2020-2023',
                        degree: 'High School',
                        institution: 'InstallPane Rising High School',
                      ),
                    ],
                  ),
                ),

                // Add Download CV Button here:
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _downloadCV,
                    icon: const Icon(Icons.download),
                    label: const Text('Download CV'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[900]!.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
      ),
      child: child,
    );
  }

  // Function to launch URL for downloading CV
  void _downloadCV() async {
    const url =
        'https://drive.google.com/file/d/1IQNYyJA9Lx41auWLe4w5p7VffVnasP4v/view?usp=sharing'; // <-- ប្ដូរជា link CV ពិតរបស់អ្នក
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch CV download link')),
      );
    }
  }
}

class EducationItem extends StatelessWidget {
  final String period;
  final String degree;
  final String institution;

  const EducationItem({
    super.key,
    required this.period,
    required this.degree,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            period,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                degree,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                institution,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
