import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/Addpost.dart';
import 'package:flutter_application_6/screens/adddata.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
import 'package:flutter_application_6/screens/profilepicture.dart';
import 'package:flutter_application_6/widgets/background-color.dart';

//import 'package:flutter_application_6/screens/signup.dart';
//import 'package:flutter_application_6/screens/constants.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_6/widgets/image_slider.dart';

import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter_application_6/screens/Searchbar.dart';

import '../../model/get_data_home.dart';
import 'Plantscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User? user) {
      // Changed to User?
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // Handle the case where the user is not null, if necessary
      }
    });
  }

  //const HomePage({super.key});

  // Define the pages to be displayed in each tab
  final List<Widget> _pages = [
    Placeholder(), // Example page 1
    Placeholder(), // Example page 2
    Placeholder(), // Example page 3
  ];

  // Handle tap on bottom navigation bar items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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
      // Color(0xFF58BB80),

      appBar: AppBar(
        elevation: 0.0,
        leading: Container(
          padding: EdgeInsets.all(1),
          child: Image.asset('assets/logo1.png'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Color.fromARGB(255, 5, 77, 59),
            ),
            onPressed: () {
              print("done");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddData()),
                );
              },
              icon: Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Color.fromARGB(255, 5, 77, 59),
              )),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Color.fromARGB(255, 5, 77, 59),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Open the end drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFF054D3B),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                //Navigate to another page when the ListTile is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePicure()),
                );
                // Handle tap on Settings
              },
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
                title: Text('My Account',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                //Navigate to another page when the ListTile is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPost()),
                );
                // Handle tap on Settings
              },
              child: ListTile(
                leading: Icon(
                  Icons.post_add,
                  color: Colors.white,
                ),
                title: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.people_alt,
                color: Colors.white,
              ),
              title: Text('Community',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // Handle tap on Settings
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text('Settings',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                // Handle tap on Settings
              },
            ),
            GestureDetector(
              onTap: () {
                instance.signOut();
                //Navigate to another page when the ListTile is tapped
                //  Navigator.push(
                //    context,
                //    MaterialPageRoute(builder: (context) => LoginPage()),
                //  );
                // Handle tap on Settings
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text('Log Out',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            // Add more ListTiles for additional sidebar items
          ],
        ),
      ),

      body: Stack(
        children: [
          BackgroundColor(),
          SingleChildScrollView(
            child: Positioned.fill(
                child: Container(
                    margin: EdgeInsets.all(9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome UserName !',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 77, 59),
                          ),
                        ),
                        Text(
                          'Take care of your plant',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 5, 77, 59),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ImageSlider(imageUrls: [
                          'https://hips.hearstapps.com/hmg-prod/images/jade-plant-1-645157c445e14.jpg?crop=1.00xw:0.829xh;0,0&resize=1200:*',
                          'https://www.ikea.com/ca/en/images/products/fejka-artificial-potted-plant-indoor-outdoor-monstera__0614197_pe686822_s5.jpg',
                          'https://www.shutterstock.com/image-photo/young-schefflera-potted-plant-isolated-260nw-526198357.jpg',
                        ]),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Indoor',
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 77, 59),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                    height: 250,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('category').where('Place', isEqualTo: 'Indoor').snapshots(),
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
                                "لا يوجد اقسام الان برجاء المتابعه",
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

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: productsBySection.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = productsBySection[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return Plantscreen(Product: productsBySection[index]);
                                }));
                              },
                              child: Container(
                                width: 200,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                      ),
                                      width: 200,
                                      height: 180,
                                      child: Image.network(
                                        product.imageUrls![0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.planetName ?? 'No Name',
                                          maxLines: 1,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                            color: product.isFavorite == true ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              product.isFavorite = !product.isFavorite;
                                            });
                                            _toggleFavorite(product);
                                            product.isFavorite == true? FirebaseFirestore.instance.collection("category").doc(product.idPlants).update({
                                              "isFavorite":true,
                                            }) :FirebaseFirestore.instance.collection("category").doc(product.idPlants).update({
                                              "isFavorite":false,
                                            }) ;
                                          },
                                        ),
                                      ],
                                    ),
                                    Text('${product.plantPricing ?? 'No Price'} EG'),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15),
                        );

                      },
                    ),
                  ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Outdoor',
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 77, 59),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                    height: 250,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('category').where('Place', isEqualTo: 'Outdoor').snapshots(),
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
                                "لا يوجد اقسام الان برجاء المتابعه",
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

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: productsBySection.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = productsBySection[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return Plantscreen(Product: productsBySection[index]);
                                }));
                              },
                              child: Container(
                                width: 200,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                      ),
                                      width: 200,
                                      height: 180,
                                      child: Image.network(
                                        product.imageUrls![0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.planetName ?? 'No Name',
                                          maxLines: 1,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                                            color: product.isFavorite == true ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              product.isFavorite = !product.isFavorite;
                                            });
                                            _toggleFavorite(product);
                                            product.isFavorite == true? FirebaseFirestore.instance.collection("category").doc(product.idPlants).update({
                                              "isFavorite":true,
                                            }) :FirebaseFirestore.instance.collection("category").doc(product.idPlants).update({
                                              "isFavorite":false,
                                            }) ;
                                          },
                                        ),
                                      ],
                                    ),
                                    Text('${product.plantPricing ?? 'No Price'} EG'),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15),
                        );
                      },
                    ),
                  ), SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Outdoor',
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 77, 59),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                    height: 250,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('diseases').snapshots(),
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
                                "لا يوجد اقسام الان برجاء المتابعه",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }

                        List<disease> productsBySection = documents.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          return disease.fromJson(data);
                        }).toList();

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: productsBySection.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = productsBySection[index];

                            return GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                width: 200,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                                      ),
                                      width: 200,
                                      height: 180,
                                      child: Image.network(
                                        product.imageUrls![0],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product.diseaseName ?? 'No Name',
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15),
                        );
                      },
                    ),
                  ),

                      ],
                    ))),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
