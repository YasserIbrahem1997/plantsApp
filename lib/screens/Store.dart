import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/screens/Searchbar.dart';
import 'package:flutter_application_6/screens/Serach_Store.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';

import 'e-commerce_screens/Shoppingcart.dart';


class StorePage extends StatelessWidget {

  
  int _selectedIndex = 2;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo1.png'),
        actions: [
            IconButton(
                    icon:GestureDetector(
            onTap: () {
              // Navigate to another page when the IconButton is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchStore()),
              );
            },
            child: Icon(
              Icons.search , 
              size: 30,
              color: Color.fromARGB(255, 5, 77, 59)
              ),
              ),
                    onPressed: () {
                            // Add functionality for search icon here
                     },
                      ),
                  IconButton(
                    icon:GestureDetector(
            onTap: () {
              // Navigate to another page when the IconButton is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage()),
              );
            },
            child: Icon(Icons.shopping_cart_outlined, size:30,color: Color.fromARGB(255, 5, 77, 59)
            ),
                  
                  ),
          onPressed: () {
              // Add functionality for search icon here
           },
                  ),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xffbdeac4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            
          ),
          
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plantopia',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 77, 59),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'is here for you!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 77, 59),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                   // Add functionality for Box 1 here
                  },
                  child: buildOutlinedBox('All'),
                ),
                GestureDetector(
                  onTap: () {
// Add functionality for Box 2 here
                  },
                  child: buildOutlinedBox('Indoor'),
                ),
                GestureDetector(
                  onTap: () {
// Add functionality for Box 3 here
                  },
                  child: buildOutlinedBox('Outdoor'),
                ),
                GestureDetector(
                  onTap: () {
// Add functionality for Box 4 here
                  },
                  child: buildOutlinedBox('Cactus'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'popularity',
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 5, 77, 59)),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 3, // Number of boxes per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 5 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 6 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 7 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 8 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 9 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 10 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 11 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 12 here
                    },
                    child: buildLargeOutlinedBox(),
                  ),
                  GestureDetector(
                    onTap: () {
// Add functionality for Box 13 here
                    },
                    child: buildSmallOutlinedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        
      ),
      
    );
  }
  
  void setState(Null Function() param0) {}
}

//4 buttons
Widget buildOutlinedBox(String text) {
  return Container(
    width: 80,
    height: 40,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xff4d6853),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Color(0xff4d6853),
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

//9 buttons
Widget buildLargeOutlinedBox() {
  return Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xff4d6853),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    // Add your image widget here
    child: Container(),
  );
}

Widget buildSmallOutlinedBox() {
  return Container(
    width: 60,
    height: 40,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0xff4d6853),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    // Add your image widget here
    child: Container(),
  );
}
