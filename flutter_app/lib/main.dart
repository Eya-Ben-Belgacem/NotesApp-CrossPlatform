import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());//lancement de l'application mobile 
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});
//création de l'interface graphique de l'application mobile
  @override
  Widget build(BuildContext context) {
    return MaterialApp(           
      home: LayoutDemo(),  
    );
  }
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            color: Colors.blue,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFECF0F1),
              child: Center(
                child: Text(
                  'Content',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            color: Color(0xFF2C3E50),
            child: Center(
              child: Text(
                'Footer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}