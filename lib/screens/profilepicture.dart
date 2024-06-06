import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/auth/login.dart';
import 'package:flutter_application_6/screens/auth/signup.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';
import 'package:flutter_application_6/widgets/dropdown.dart';

import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePicure extends StatefulWidget {
  const ProfilePicure({key});

  @override
  State<ProfilePicure> createState() => _ProfilePicureState();
}

class _ProfilePicureState extends State<ProfilePicure> {
  File? _image;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Color emailBoxColor =
      Color.fromARGB(196, 0, 170, 133); // لون صندوق البريد الإلكتروني

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Your Profile',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 1, 8, 6),
          ),
        ),
        leading:  IconButton(
        icon:Icon(Icons.arrow_back_ios, 
           size: 50, 
           color:  Color.fromARGB(255, 5, 77, 59),
           weight:300, ),
           onPressed: () {
        Navigator.pop(context); // Navigate back
      },
        ),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.push(
               context,
              MaterialPageRoute(
               builder:
         (context) => HomePage()), // Replace SecondPage() with the page you want to navigate to
                );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor:Color.fromARGB(255, 99, 199, 165),
              ),

              child: Text(
                'Skip' ,
                style: 
                TextStyle(color:Colors.white),
                ),
                ),
            ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImageFromGallery,
              child: _image == null
                  ? Container(
                      margin: EdgeInsets.only(top: 0.0),
                      width: 175,
                      height: 175,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/profile 1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Image.file(_image!),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23)
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                fillColor: Color.fromARGB(
                    255, 99, 199, 165), // لون بوكس النص للإسم الكامل
                filled: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'User name ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                fillColor: Color.fromARGB(255, 99, 199, 165), // لون بوكس النص للإسم الكامل
                filled: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                fillColor: Color.fromARGB(255, 99, 199, 165), // لون بوكس النص للإسم الكامل
                filled: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                fillColor: Color.fromARGB(255, 99, 199, 165), // لون بوكس النص للإسم الكامل
                filled: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'poppins',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15,),
            Container(
              child: DateDropdowns(
                
              ),
            ),
            
            SizedBox(height: 16),
          Container(
            height: 50,
            width: 110,
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 43, 165, 120),
            borderRadius: BorderRadius.circular(20)),
            child: TextButton(
                onPressed: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
                  },
                ));
              },
             child: Text(
              'Register',
              style: TextStyle(
                  color: Colors.white, fontSize: 17),
                    ),
                    ),
                    ),
          ],
        ),
      ),
    );
  }
}
