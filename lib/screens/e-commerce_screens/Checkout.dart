import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';

import '../../model/get_data_home.dart';
import '../../widgets/background-color.dart';

class CheckoutPage extends StatelessWidget {
  int? price;
  int?  totalPriceFinal;
  TextEditingController FullNameController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            size: 40,
            color: Color.fromARGB(255, 5, 77, 59),
            weight: 300,),
          onPressed: () {

            Navigator.pop(context);
          },
        ),
        title:
        Text(
          'Checkout',
          style: TextStyle(
            color: ( Color.fromARGB(255, 5, 77, 59)),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),



        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(1),
            child: Image.asset('assets/logo1.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('ShoppingCart').doc(FirebaseAuth.instance.currentUser!.email).collection("checkout").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            var documents = snapshot.data?.docs ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20), // إضافة مسافة بين النص وحقل الإدخال
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), // زيادة التدوير هنا
                    border: Border.all(color: Color.fromRGBO(178, 204, 195, 80)),
                    color: Color.fromRGBO(178, 204, 195, 80)
                        .withOpacity(0.1), // تغيير لون الحدود هنا
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: FullNameController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون الأيقونة هنا
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون نص العنوان هنا
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // إضافة مسافة بين حقول الإدخال
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), // زيادة التدوير هنا
                    border: Border.all(color: Color.fromRGBO(178, 204, 195, 80)),
                    color: Color.fromRGBO(178, 204, 195, 80)
                        .withOpacity(0.1), // تغيير لون الحدود هنا
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_on,
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون الأيقونة هنا
                        labelText: 'Address',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون نص العنوان هنا
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // إضافة مسافة بين حقول الإدخال
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), // زيادة التدوير هنا
                    border: Border.all(color: Color.fromRGBO(178, 204, 195, 80)),
                    color: Color.fromRGBO(178, 204, 195, 80)
                        .withOpacity(0.1), // تغيير لون الحدود هنا
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone,
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون الأيقونة هنا
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(
                                5, 77, 59, 100)), // تغيير لون نص العنوان هنا
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // إضافة مسافة بين حقول الإدخال

                Text(
                  'Payment : In Cash',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                // إضافة مسافة بين حقول الإدخال

                Text(
                  'Order',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child:StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ShoppingCart')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection('Items')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
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
                              "Your cart is empty",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                      List<ProductCart> productsBySection = documents.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                         price = int.parse(data['price']);
                        print('Price from document: $price');
                        return ProductCart.fromJson(data);
                      }).toList();

// Calculate the total price
                      totalPriceFinal = productsBySection.fold(0, (sum, product) => sum! + price!);
                      print('Total Price: $totalPriceFinal');


                      return Stack(
                        children: [
                          BackgroundColor(),
                          if (productsBySection.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFF054D3B),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: Text(
                                'You have ${productsBySection.length} items in your cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),

                        ],
                      );
                    },
                  ),
                ),

                Center(
                  child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 43, 165, 120),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextButton(
                          onPressed: (){

                              // Send order details to 'HistoryOrder' collection
                              FirebaseFirestore.instance.collection('HistoryOrder').add({
                                'fullName': FullNameController.text, // Replace with actual data from TextField
                                'address': addressController.text, // Replace with actual data from TextField
                                'phone': phoneController.text, // Replace with actual data from TextField
                                'totalPrice': totalPriceFinal,
                                'items': documents.map((doc) {
                                  var data = doc.data() as Map<String, dynamic>;
                                  return {
                                    'name': data['planetName'],
                                    'price': data['price'],
                                  };
                                }).toList(),
                              }).then((value) {

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('done order')),

                                );
                              }).catchError((error) {
                                // Handle error
                                print("Failed to add order details: $error");
                              });

                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                color: Colors.white, fontSize: 17),
                          )
                      )
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
