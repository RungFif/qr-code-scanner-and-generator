import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ), // 1.2 seconds for smoothness
    );

    // 2. Define Animations (Bounce effect for logo, Fade for text)
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // 3. Start Animation
    _controller.forward();

    // 4. Timer to navigate to Home (use explicit route to avoid missing named routes)
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Beautiful Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF553FB8), // Brand Purple
              Color(0xFF7C5CFF), // Lighter Purple for depth
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Animated Logo Section ---
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), // Glassmorphism effect
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.contain,
                  // Fallback icon in case image is missing
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.qr_code_2,
                      size: 80,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- Animated Text Section ---
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: const [
                  Text(
                    'QRODE',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'QR Generator • Scanner',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // --- Loading Indicator ---
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
