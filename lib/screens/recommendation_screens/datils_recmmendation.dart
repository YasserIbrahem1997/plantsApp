import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/get_data_home.dart';
class DetailsRecommendationScreen extends StatefulWidget {
  final ProductHome Product;
  DetailsRecommendationScreen({required this.Product});

  @override
  State<DetailsRecommendationScreen> createState() => _DetailsRecommendationScreenState();
}

class _DetailsRecommendationScreenState extends State<DetailsRecommendationScreen> {
  void _toggleFavorite(ProductHome product) async {
    final userId = FirebaseAuth.instance.currentUser!.email;
    final favoritesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites');

    if (product.isFavorite) {
      // Add to favorites
      await favoritesCollection.doc(product.planetName).set(product.toJson());
    } else {
      // Remove from favorites
      await favoritesCollection.doc(product.planetName).delete();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Color(0xff8fd0ac), // Mint Green
                    // Adjust height as needed
                    alignment: Alignment.center,
                    child: Image.network(
                      widget.Product.imageUrls![0], // Use product's image URL
                      fit: BoxFit.cover,// Adjust height as needed
                      height: MediaQuery.of(context).size.height /2.5,
                      width: double.infinity,

                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 5,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                        size: 50,
                        color:  Color.fromARGB(255, 5, 77, 59),
                        weight:300,),
                      onPressed: () {
                        Navigator.pop(context);// Add your back navigation logic here
                      },
                    ),
                  ),
                ],
              ),
              Container(

                alignment: Alignment.topLeft, // Align text to top left
                padding: EdgeInsets.only(left: 20, top: 10), // Adjust padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plant Name',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff000000),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            widget.Product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                            color: widget.Product.isFavorite == true ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.Product.isFavorite = !widget.Product.isFavorite;
                            });
                            _toggleFavorite(widget.Product);
                            widget.Product.isFavorite == true? FirebaseFirestore.instance.collection("category").doc(widget.Product.idPlants).update({
                              "isFavorite":true,
                            }) :FirebaseFirestore.instance.collection("category").doc(widget.Product.idPlants).update({
                              "isFavorite":false,
                            }) ;
                          },
                        ),
                      ],
                    ),
                    Text(
                      widget.Product.planetName.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),
                    SizedBox(height: 5), // Spacer between text and divider
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),
                    SizedBox(
                        height: 10), // Spacer between divider and About text
                    Text(
                      'Place Plants',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.Product.Place.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),// Spacer between text and divider
                    SizedBox(height: 5), // Spacer between text and divider
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),
                    SizedBox(
                        height: 10),
                    // Spacer between divider and About text
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.Product.planetDescriotion.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),
                    // Spacer between About text and new text field
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.Product.date.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),
                    // Spacer between About text and new text field
                    Text(
                      'Start Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.Product.StartDate.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),

                    Text(
                      'End Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),

                    Text(
                      widget.Product.EndDate.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff979595),
                      ),
                    ),


                    SizedBox(height: 5), // Spacer between text and divider
                    SizedBox(
                      height: 2, // Adjust height of the divider
                      width: 320, // Adjust width of the divider
                      child: Divider(
                        color: Color(0xff818181), // Adjust color of the divider
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}