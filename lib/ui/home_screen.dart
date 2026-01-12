import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRODE Dashboard'),
        automaticallyImplyLeading: false, // Removes back button after splash
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Image or Icon
              const Icon(
                Icons.qr_code_2_rounded,
                size: 100,
                color: Color(0xFF553FB8),
              ),
              const SizedBox(height: 40),
              
              // Button 1: Scan QR
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Scanner
                  Navigator.pushNamed(context, '/scan');
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Scan QR Code'),
              ),
              
              const SizedBox(height: 16),
              
              // Button 2: Generate QR
              OutlinedButton.icon(
                onPressed: () {
                   // Navigate to Generator
                   Navigator.pushNamed(context, '/create');
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Create QR Code'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF553FB8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}