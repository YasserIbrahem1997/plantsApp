import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
//import 'package:flutter_application_6/screens/login.dart';
//import 'package:flutter_application_6/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';


void main() async 
{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
 );
  runApp(const MyApp()); 
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Color customColor = Color(0xFF2BA578);
    //Color customColor = Color(0xFFE8F6B8);

    return MaterialApp(
      title: 'Plantopia',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: HomePage(),
    );
  }
}
