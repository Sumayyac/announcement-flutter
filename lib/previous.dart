import 'package:flutter/material.dart';

class Previouspage extends StatelessWidget {
  const Previouspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('previous message'),
        backgroundColor: const Color.fromARGB(255, 203, 102, 14),
      ),
      body: Center(
        child: Text('This is the previous Page'),
      
      ),
    );
  }
}