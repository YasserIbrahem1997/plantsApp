import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  ImageSlider({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0, // Adjust the height of the slider
        enlargeCenterPage: true, // Enable center page enlargement
        autoPlay: true, // Enable auto play
        aspectRatio: 16 / 9, // Define aspect ratio of images
        autoPlayInterval: Duration(seconds: 3), // Set auto play interval
        autoPlayCurve: Curves.fastOutSlowIn, // Set auto play animation curve
        enableInfiniteScroll: true, // Enable infinite scroll
        autoPlayAnimationDuration: Duration(milliseconds: 800), // Set animation duration
        viewportFraction: 0.8, // Define fraction of viewport to show
      ),
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}


