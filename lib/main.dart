import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';

// Ensure these files exist in your 'lib/ui/' folder
import 'ui/splash_screen.dart';
import 'ui/home_screen.dart';
import 'ui/qr_generator/qr_generator_screen.dart';
import 'ui/qr_scanner/qr_scanner_screen.dart';

void main() {
  runApp(
    DevicePreview(
      // Only enable DevicePreview in debug mode, not in release app
      enabled: !kReleaseMode,

      // Set the default device to show on startup
      defaultDevice: Devices.ios.iPhone13ProMax,

      // List of devices available in the preview menu
      devices: [
        Devices.ios.iPhone13ProMax,
        Devices.android.samsungGalaxyS20,
        Devices.ios.iPadPro11Inches,
      ],

      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // --- Device Preview Integration ---
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      // ----------------------------------
      debugShowCheckedModeBanner: false,
      title: 'QRODE - QR Generator & Scanner',

      // --- Global Theme (Material 3) ---
      theme: ThemeData(
        fontFamily: 'Manrope', // Ensure font is added to pubspec.yaml
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF553FB8), // Your Brand Color
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(
          0xFFF8F9FA,
        ), // Clean off-white background
        // Global App Bar Styling
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // Removes M3 tint
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A1A),
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
        ),

        // Global Button Styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF553FB8),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),

      // --- Routing ---
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const QrGeneratorScreen(),
        '/scan': (context) => const QrScannerScreen(),
      },
    );
  }
}
