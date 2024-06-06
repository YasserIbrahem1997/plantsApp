import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/auth/forgetpass.dart';
import 'package:flutter_application_6/screens/e-commerce_screens/homepage.dart';
import 'package:flutter_application_6/screens/auth/signup.dart';
import 'package:flutter_application_6/widgets/background-image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  late num phonenumber;
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          backgroundimage(),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Center(
                    child: Image(image: AssetImage('assets/logo.png')),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'LOGIN',
                  style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 84, 64)),
                ),

                SizedBox(height: 10),
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 237, 255),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            this.email = value;
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                            border: InputBorder.none,
                            hintText: 'Phone Number OR Email',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: 33,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 237, 255),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            this.password = value;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                            border: InputBorder.none,
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 33,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                //login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: GestureDetector(
                    onTap: ()async {
                      try {
                      await instance.signInWithEmailAndPassword(
                            email: this.email, password: this.password);
                            Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage()), // Replace NextScreen() with the screen you want to navigate to
                      );
                      } catch (e) {
                        
                      }
                      
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(13, 152, 106, 100),
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //text 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login ',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'with Others',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                //google
                Center(
                  child: OutlinedButton(
                    onPressed: _handleSignIn,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Border radius
                          );
                        },
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/google 1 (1).png',
                          alignment: Alignment.center,
                          // Add your Google logo asset here
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'log in with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: OutlinedButton(
                      onPressed: _handleSignIn,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius
                            );
                          },
                        ),
                      ),
                      //sign in with facebook
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/facebook 1.png',
                            alignment: Alignment.center,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'log in with Facebook',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),

                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // Navigate to the Sign Up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassPage()),
                    );
                  },

                  // text 2

                  child: Text('Forget password ?',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 170, 0, 14))),
                ),

                SizedBox(height: 11),

                //text 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'T Have Acount? ',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 3, 14, 23)),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Sign Up page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          //  decoration:TextDecoration.underline,
                          color: Color.fromARGB(255, 43, 165, 120),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _handleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signIn();
      // Sign in was successful, handle the user's data
      // For example, you can get user details using:
      // GoogleSignInAccount? user = googleSignIn.currentUser;
    } catch (error) {
      // Handle the sign-in error
      print('Error signing in: $error');
    }
  }
}
