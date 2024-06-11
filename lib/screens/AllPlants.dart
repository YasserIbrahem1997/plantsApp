import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/model/get_data_home.dart';
import 'package:flutter_application_6/screens/reminders/reminders.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';

import 'e-commerce_screens/Plantscreen.dart';

class AllPlantsPage extends StatelessWidget {
  
    int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          BackgroundColor(),
          // تركيب الصورة في أعلى الصفحة
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/logo1.png', // قم بتغيير هذا بمسار واسم ملف الصورة الخاص بك
                width: 170,
                height: 170,
              ),
            ),
          ),
          // اضافه كلمه
          Positioned(
            top: 110, // تحديد الارتفاع من الأعلى
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Garden',
                style: TextStyle(
                    fontSize: 46,
                    //fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 77, 59)),
              ),
            ),
          ),
          Positioned(
              top: 180, // تحديد الارتفاع من الأعلى
              left: 0,
              right: 0,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(88, 187, 128, 100), // حدود مستديرة
                      border: Border.all(
                        color: Color.fromRGBO(88, 187, 128, 100), // لون الحدود
                        width: 2, // سمك الحدود
                      ),
                    ),
                    child: TextButton(
                      child: Text('All Favorite ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AllPlantsPage();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 5), 
                  Column(children: [// مسافة بين العناصر
                  Container(
                    
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Color.fromRGBO(88, 187, 128, 100),
                      border: Border.all(
                        color: Color.fromRGBO(88, 187, 128, 100), // لون الحدود
                        width: 2, // سمك الحدود
                      ),
                    ),
                    child: TextButton(
                      child: Text('Reminders',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ReminderPage();
                          },
                        )
                        );
                      },
                    ),
                  ),
                ],
              )
                ],
                
              ),
              ),
              ),

          Positioned(
            top: 240,
            left: 10,
            right: 10,
            bottom: 10,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection("favorites").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                var documents = snapshot.data?.docs ?? [];

                if (documents.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "No Have Favorite",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }

                List<ProductHome> productsBySection = documents.map((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  return ProductHome.fromJson(data);
                }).toList();

                return ListView.builder(
                  itemCount:productsBySection.length,
                  itemBuilder: (context, index) {
                    var product = productsBySection[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return Plantscreen(Product: product);
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffa5cab9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width:130,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.imageUrls![0],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex:4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.planetName.toString(),
                                            style: TextStyle(
                                              fontSize: 15,

                                              color: Color.fromARGB(255, 4, 84, 64),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                           product.plantPricing.toString() + " EG",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(255, 4, 84, 64),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 40,bottom: 30),
                                      child: IconButton(
                                        icon: Icon(Icons.favorite,),
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email).collection("favorites").doc(product.planetName).delete();
                                          FirebaseFirestore.instance.collection("category").doc(product.idPlants).update({
                                            "isFavorite":false,
                                          });
                                        },
                                        color: Colors.red,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

              },
            ),
          ),

        ],
          ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}

