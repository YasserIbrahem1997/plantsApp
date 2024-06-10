import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/AllPlants.dart';
import 'package:flutter_application_6/screens/Community.dart';
import 'package:flutter_application_6/screens/ProfilePage.dart';
import 'package:flutter_application_6/screens/Store.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';
import 'package:flutter_application_6/screens/reminders/reminders.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon:GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()
        ), // Replace YourPage() with the page you want to navigate to
      );
    },
    child: Icon(Icons.home, size: 30),),

          label: 'Home',

        ),
        BottomNavigationBarItem(
          icon:GestureDetector(
            onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommunityPage()), // Replace YourPage() with the page you want to navigate to
      );
         },

            child:  Icon(Icons.handshake_outlined, size: 30),),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon:GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StorePage()), // Replace YourPage() with the page you want to navigate to
      );
    },
    child:  Icon(Icons.shopping_cart, size: 30),
    ),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon:GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllPlantsPage()
        ), // Replace YourPage() with the page you want to navigate to
      );
    },child: Icon(Icons.alarm, size: 30),),
          label: 'Reminder',
        ),
        BottomNavigationBarItem(
          icon:GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()
        ), // Replace YourPage() with the page you want to navigate to
      );
    },child: Icon(Icons.account_circle_outlined, size: 30),),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Color.fromARGB(255, 0, 11, 64),
      unselectedItemColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 88, 187, 128),
    );
  }
}
