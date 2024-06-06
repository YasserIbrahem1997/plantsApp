import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter_application_6/widgets/outlinedbutton.dart';

import 'RecommendedPlants.dart';

class Recommendation extends StatefulWidget {
//  const Recommendation({super.key});


  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  String? selectedValueLight;
  String? selectedValueDifficulty;
  String? selectedValueColor;
  String? selectedValuePlace;
  final Map<int, String?> _selectedOptions = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
      IconButton(
        icon:Icon(Icons.arrow_back_ios,
           size: 25,
           color:  Color.fromARGB(255, 5, 77, 59),
           weight:300, ),
           onPressed: () {
        Navigator.pop(context); // Navigate back
      },
        ),
    actions: [
      Image.asset('assets/logo1.png'),
    ],
      ),

      body: Stack(
        children: [
          BackgroundColor(),
          Padding(padding: EdgeInsets.only(left: 10, top: 18,right: 10),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'WHAT ARE YOU INTERESTED IN?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color:Color.fromARGB(255, 5, 77, 59)),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Light needed to plant',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.15,
                                style: BorderStyle.solid))),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                    hint: selectedValueLight == null
                        ? Container(
                        child: Text(
                          "select Light needed to plant",
                          textAlign: TextAlign.right,
                          style: TextStyle(),
                        ))
                        : Container(
                      child: Text(
                        "${selectedValueLight.toString()}",
                        style: TextStyle(
                          fontSize: 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    items: <String>[
                      'Full sun',
                      'part sun',
                      'part shade',
                    ]
                        .map(
                          (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                        .toList(),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 260,
                    onChanged: (valueSelcet) async {
                      selectedValueLight = valueSelcet;
                      print(selectedValueLight);
                    },
                  ),
                ),
                SizedBox(height: 10), SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    "Place",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.15,
                                style: BorderStyle.solid))),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                    hint: selectedValuePlace == null
                        ? Container(
                        child: Text(
                          "select Place",
                          textAlign: TextAlign.right,
                          style: TextStyle(),
                        ))
                        : Container(
                      child: Text(
                        "${selectedValuePlace.toString()}",
                        style: TextStyle(
                          fontSize: 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    items: <String>[
                      'Indoor',
                      'Outdoor'
                    ]
                        .map(
                          (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                        .toList(),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 260,
                    onChanged: (valueSelcet) async {
                      selectedValuePlace = valueSelcet;
                      print(selectedValuePlace);
                    },
                  ),
                ),
                SizedBox(height: 10), SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    'PLANT DIFFICULTY',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.15,
                                style: BorderStyle.solid))),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                    hint: selectedValueDifficulty == null
                        ? Container(
                        child: Text(
                          "select Difficulty",
                          textAlign: TextAlign.right,
                          style: TextStyle(),
                        ))
                        : Container(
                      child: Text(
                        "${selectedValueDifficulty.toString()}",
                        style: TextStyle(
                          fontSize: 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    items: <String>[
                     ' Easy',
                      'Medium',
                      'Hard'
                    ]
                        .map(
                          (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                        .toList(),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 260,
                    onChanged: (valueSelcet) async {
                      selectedValueDifficulty = valueSelcet;
                      print(selectedValueDifficulty);
                    },
                  ),
                ),
                SizedBox(height: 10), SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: Text(
                    'FLOWER_COLOR',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.15,
                                style: BorderStyle.solid))),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w800),
                    hint: selectedValueColor == null
                        ? Container(
                        child: Text(
                          "select FLOWER_COLOR",
                          textAlign: TextAlign.right,
                          style: TextStyle(),
                        ))
                        : Container(
                      child: Text(
                        "${selectedValueColor.toString()}",
                        style: TextStyle(
                          fontSize: 4,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    items: <String>[
                      'Red',
                      'Yellow',
                      'Green',
                      'Pink',
                      'white',
                      'orange',
                      'Violet',
                      'Blue',
                      'Purple',
                      'Multi Colors'
                    ]
                        .map(
                          (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                        .toList(),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 260,
                    onChanged: (valueSelcet) async {
                      selectedValueColor = valueSelcet;
                      print(selectedValueColor);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 43, 165, 120),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextButton(
                          onPressed: () async {
                            // Print selected values to debug
                            print('Selected Light: $selectedValueLight');
                            print('Selected Place: $selectedValuePlace');
                            print('Selected Difficulty: $selectedValueDifficulty');
                            print('Selected Color: $selectedValueColor');
                            // Fetch the data from Firestore
                            final querySnapshot = await FirebaseFirestore.instance
                                .collection('category')
                                // .where('lightNeeded', isEqualTo: selectedValueLight)
                                .where('Place', isEqualTo: selectedValuePlace)
                                // .where('difficult', isEqualTo: selectedValueDifficulty)
                                .where('FlowerColor', isEqualTo: selectedValueColor)
                                .get();


                            // Extract the data
                            final List<Map<String, dynamic>> plants = querySnapshot.docs
                                .map((doc) {
                              print('Document: ${doc.data()}'); // Print each document's data
                              return doc.data() as Map<String, dynamic>;
                            })
                                .toList();

                            // Print the list of plants
                            print('Fetched Plants: $plants');
                            // Navigate to the recommended plants page with data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Recommendedplants(plants: plants),
                              ),
                            );
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white, fontSize: 17),
                          )
                      )
                  ),
                ),
              ],

            ),

          ),

        ],
      ),


    );
  }
}






