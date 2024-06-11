import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
//import 'package:flutter_application_6/screens/login.dart';
//import 'package:flutter_application_6/screens/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
void main() async
{
  tz.initializeTimeZones();
  var locations = tz.timeZoneDatabase.locations;

  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
 );
  runApp(const MyApp()); 
}


class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plantopia',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: HomePage(),
    );
  }
}
