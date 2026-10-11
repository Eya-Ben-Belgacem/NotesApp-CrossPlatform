import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            color: const Color(0xFF3498DB),
            alignment: Alignment.center,
            child: const Text(
              'Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFECF0F1),
              alignment: Alignment.center,
              child: const Text('Content', style: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            height: 60,
            color: const Color(0xFF2C3E50),
            alignment: Alignment.center,
            child: const Text(
              'Footer',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}