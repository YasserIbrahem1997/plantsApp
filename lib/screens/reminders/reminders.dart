import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/AllPlants.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'add_reminders.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<ReminderPage> {
  int _selectedIndex = 3;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      // Handle notification message when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      // Handle notification message when the app is opened from a terminated state
    });
  }

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
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/logo1.png',
                width: 170,
                height: 170,
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Garden',
                style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 77, 59)),
              ),
            ),
          ),
          Positioned(
            top: 180,
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
                      color: Color.fromRGBO(88, 187, 128, 100),
                      border: Border.all(
                        color: Color.fromRGBO(88, 187, 128, 100),
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      child: Text(
                        'All Plants',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AllPlantsPage();
                          },
                        ));
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(88, 187, 128, 100),
                      border: Border.all(
                        color: Color.fromRGBO(88, 187, 128, 100),
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      child: Text(
                        'Reminders',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ReminderPage();
                          },
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.65,
              color: Colors.transparent,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('reminders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No reminders found.'));
                  }
                  final reminders = snapshot.data!.docs;
                  return ListView.separated(
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      var reminder = reminders[index];
                      return Container(
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          title: Text(reminder['plantName']),
                          subtitle: Text(
                            'Date: ${reminder['date']} - Time: ${reminder['time']}',
                          ),
                          trailing: IconButton(
                            onPressed: (){
                              FirebaseFirestore.instance.collection('reminders').doc(reminder.id).delete();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(
                    height: 10,
                  ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddReminderPage();
            },
          ));
        },
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Color.fromRGBO(88, 187, 128, 100),
          child: Icon(
            Icons.add_outlined,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
