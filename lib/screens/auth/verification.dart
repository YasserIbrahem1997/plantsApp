import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/auth/newpassword.dart';
import 'package:flutter_application_6/widgets/background-color.dart';

class VerifyEmail extends StatelessWidget {
  final String email;

  const VerifyEmail({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Color.fromARGB(255, 5, 77, 59),
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'Verify your E-mail',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          BackgroundColor(),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: Container(
                    alignment: Alignment.center,
                    height: 1, // Height of the line
                    color: Colors.black, // Color of the line
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('assets/Mask group.png'),
                        width: 230,
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Please enter the code that you received',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 237, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 18),
                            border: InputBorder.none,
                            hintText: 'Code',
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.code_outlined,
                              size: 33,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Resend code',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 80),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 120),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPassword(email: email)),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(13, 152, 106, 100),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
