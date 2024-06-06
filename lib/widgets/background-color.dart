import 'package:flutter/material.dart';

class BackgroundColor extends StatelessWidget {
  const BackgroundColor({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xffbdeac4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            
          ),
          
        ),
      ),
      
    );
  }
}