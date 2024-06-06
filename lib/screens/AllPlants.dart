import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/reminders.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';

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
                      child: Text('All Plants ',
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
            child:   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Plants',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 84, 64),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Add your onPressed logic for '+Add Plants' button
                    },
                    child: Text(
                      '+Add Plant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 4, 84, 64),
                      ),
                    ),
                  ),
                ],
              ),
          ),
              Positioned(
            top: 270,
            left: 10,
            right: 10,
            child:
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0xffa5cab9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: -7,
                          child: Container(
                            width: 60,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffcbd4cb),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 90,
                            top: 20, // Adjusted top padding here
                            bottom: 10,
                          ), // Adjusted padding here
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Plants',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        'No Reminder set',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 4), // Add space for the line
                                      Container(
                                        height: 1.0,
                                        color: Color(
                                            0xff4d8664), // Adjust line color
                                        width:
                                            220, // Adjust line width as needed
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/Waterinjg.png', width:30, height: 30,),
                                  SizedBox(width: 20,),
                                  Image.asset('assets/Waterinjg.png', width: 30, height: 30,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
                Positioned(
            top: 400,
            left: 10,
            right: 10,
            child:
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0xffa5cab9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: -7,
                          child: Container(
                            width: 60,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffcbd4cb),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 90,
                            top: 20, // Adjusted top padding here
                            bottom: 10,
                          ), // Adjusted padding here
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Plants',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        'No Reminder set',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 4), // Add space for the line
                                      Container(
                                        height: 1.0,
                                        color: Color(
                                            0xff4d8664), // Adjust line color
                                        width:
                                            220, // Adjust line width as needed
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/Waterinjg.png', width:30, height: 30,),
                                  SizedBox(width: 20,),
                                  Image.asset('assets/Waterinjg.png', width: 30, height: 30,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                ),
            Positioned(
            top: 530,
            left: 10,
            right: 10,
            child:
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(0xffa5cab9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: -7,
                          child: Container(
                            width: 60,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffcbd4cb),
                              shape: BoxShape.circle,
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 90,
                            top: 20, // Adjusted top padding here
                            bottom: 10,
                          ), // Adjusted padding here
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Plants',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(height: 1),
                                      Text(
                                        'No Reminder set',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 4, 84, 64),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 4), // Add space for the line
                                      Container(
                                        height: 1.0,
                                        color: Color.fromARGB(255, 4, 84, 64), // Adjust line color
                                        width:
                                            220, // Adjust line width as needed
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/Waterinjg.png', width:30, height: 30,),
                                  SizedBox(width: 20,),
                                  Image.asset('assets/Waterinjg.png', width: 30, height: 30,)
                                ],
                              ),
                            ],
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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}
