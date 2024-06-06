import 'package:flutter/material.dart';

class backgroundimage extends StatelessWidget {
  const backgroundimage({
    key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask (
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.transparent, Colors.black],
        begin: Alignment.bottomCenter,
        end: Alignment.topRight,
     ).createShader(bounds),
     blendMode: BlendMode.lighten,
       child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/Stylizimo.jpeg.jpg'),
          fit: BoxFit.cover,
        //  colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.lighten),
        )),
        child: Container(
          color: Color.fromARGB(255, 232, 246, 184).withOpacity(0.4), // Adjust opacity as needed
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
