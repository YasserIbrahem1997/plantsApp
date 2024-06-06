import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/get_data_home.dart';
class Plantscreen extends StatelessWidget {
  final ProductHome Product;
   Plantscreen({required this.Product});

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
                      Product.imageUrls![0], // Use product's image URL
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
                    Text(
                      'Name Plants',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    Text(
                      Product.planetName.toString(),
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
                      'Price Plants',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      Product.plantPricing.toString() + " " + "LE",
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
                      Product.planetDescriotion.toString(),
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
                      Product.date.toString(),
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
                      Product.StartDate.toString(),
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
                      Product.EndDate.toString(),
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
                    Center(
                      child: ElevatedButton(
                        onPressed: () => addToCart(context),
                        child: Text('Add to Cart'),
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
  void addToCart(BuildContext context) async {


    try {
      // Reference to the user's cart
      CollectionReference cart = FirebaseFirestore.instance
          .collection('ShoppingCart')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Items');

      // Add product to the cart
      await cart.add({
        'planetName': Product.planetName,
        'price': Product.plantPricing,
        'imageUrl': Product.imageUrls![0],
        'startDate': Product.StartDate,
        'date': Product.date,
        'endDate': Product.EndDate,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to cart')),

      );
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

}
class DraggableBoxes extends StatefulWidget {
  @override
  _DraggableBoxesState createState() => _DraggableBoxesState();
}

class _DraggableBoxesState extends State<DraggableBoxes> {
  List<Offset> positions = [Offset(0, 0), Offset(0, 0), Offset(0, 0)];
  List<Color> boxColors = [
    Color(0xff919a9a),
    Color(0xff919a9a),
    Color(0xff919a9a)
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(3, (index) {
        return Transform.translate(
          offset: positions[index],
          child: Draggable<int>(
            data: index,
            feedback: buildBox(index, Colors.grey.withOpacity(0.5)),
            child: DragTarget<int>(
              onAccept: (receivedIndex) {
                setState(() {
                  // Swap the positions of the boxes
                  Offset temp = positions[index];
                  positions[index] = positions[receivedIndex];
                  positions[receivedIndex] = temp;
                });
              },
              builder: (context, acceptedData, rejectedData) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      positions[index] +=
                          Offset(details.delta.dx - 10, details.delta.dy - 10);
                    });
                  },
                  child: buildBox(index, boxColors[index]),
                );
              },
            ),
            childWhenDragging: buildBox(index, Colors.transparent),
          ),
        );
      }),
    );
  }

  Widget buildBox(int index, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color, // Adjust color as needed
        borderRadius: BorderRadius.circular(10), // Adjust radius as needed
      ),
    );
  }
}