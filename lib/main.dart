import 'package:flutter/material.dart';
import 'about_page.dart';
import 'service_page.dart'; //
import 'contact_page.dart'; // Import ContactPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Developer Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF042A4B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.cyanAccent),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Futuristic Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF042A4B),
                  Color(0xFF063970),
                  Color(0xFF0A4B8C),
                ],
              ),
            ),
            child: CustomPaint(painter: _FuturisticBackgroundPainter()),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  title: Row(
                    children: [
                      const Text(
                        'KM',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 10, color: Colors.blue)],
                        ),
                      ),
                      const Spacer(),
                      _buildNavButton('Home'),
                      _buildNavButton('About'),
                      _buildNavButton('Skills'),
                      _buildNavButton('Contact'),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: FadeTransition(
                    opacity: _animation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          // Profile Picture with Glow
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.cyanAccent,
                                  width: 2,
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/profile.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                          const Text(
                            'MOBILE DEVELOPER',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.cyanAccent,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Ket Malismonipech',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(blurRadius: 10, color: Colors.blue),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'I am a Computer Science student at the Royal University of Phnom Penh with experience in Android app development\n using Java and Firebase. I enjoy learning new technologies and work well both independently and in a team.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(mainAxisAlignment: MainAxisAlignment.center),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text) {
    return TextButton(
      onPressed: () {
        if (text == 'About') {
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
        } else if (text == 'Skills') {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => const ServicePage(),
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
          color: (text == 'About' || text == 'Skills' || text == 'Contact')
              ? Colors.white
              : Colors.cyanAccent,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildGlowingButton(String text, Color color, {bool outline = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: outline ? Colors.transparent : color.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: color, width: 2),
        ),
        shadowColor: color.withOpacity(0.5),
        elevation: 10,
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: outline ? color : Colors.white, fontSize: 16),
      ),
    );
  }
}

class _FuturisticBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.1),
          Colors.cyanAccent.withOpacity(0.3),
          Colors.blue.withOpacity(0.1),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.6,
      size.width * 0.5,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.8,
      size.width,
      size.height * 0.7,
    );

    canvas.drawPath(
      path,
      paint
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    final linePaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.cyanAccent.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawLine(
      Offset(0, size.height * 0.75),
      Offset(size.width, size.height * 0.75),
      linePaint,
    );

    final dotPaint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 5, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.4), 7, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.8), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
