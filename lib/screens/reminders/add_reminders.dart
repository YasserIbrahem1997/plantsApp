import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/screens/AllPlants.dart';
import 'package:flutter_application_6/screens/reminders/reminders.dart';
import 'package:flutter_application_6/widgets/background-color.dart';
import 'package:flutter_application_6/widgets/bottombar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AddReminderPage extends StatefulWidget {
  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  int _selectedIndex = 3;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateTime dateTimeNow = DateTime.now();
  TextEditingController _plantNameController = TextEditingController();

  bool _isDatePickerVisible = false;
  bool _isTimePickerVisible = false;

  String? selectedValuePlace;
  String? selectedPlantId;
  String? selectTypeCateugore;
  List<DropdownMenuItem<String>> _dropdownItems = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final CollectionReference categoryCollection =
  FirebaseFirestore.instance.collection('category');
  late Stream<List<String>> categoriesStream;

  @override
  void initState() {
    categoriesStream = categoryCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => doc['planetName'] as String).toList());
    super.initState();
    AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: null,
        macOS: null,
        linux: null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

  showNotification() {
    AndroidNotificationDetails androidInitializationSettings =
    AndroidNotificationDetails("flutter_application_6", "Notify Me",
        importance: Importance.high);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidInitializationSettings,
        iOS: null,
        macOS: null,
        linux: null);
    // flutterLocalNotificationsPlugin.show(
    //     01, selectTypeCateugore, _timeController.text, notificationDetails);
      tz.initializeTimeZones();
      tz.TZDateTime scheduledAT = tz.TZDateTime.from(dateTimeNow, tz.local);
      flutterLocalNotificationsPlugin.zonedSchedule(
          0, selectTypeCateugore,
          _timeController.text,
          scheduledAT,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
          androidAllowWhileIdle: true);
  }

  Future<void> _selectDate(TextEditingController controller) async {
    try {
      final DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: dateTimeNow,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (newSelectedDate == null) {
        return;
      }
      setState(() {
        dateTimeNow = newSelectedDate;
        _dateController.text =
        "${dateTimeNow.year}/${dateTimeNow.month}/${dateTimeNow.day}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) {
      return;
    }
    _timeController.text = "${selectedTime.hour}:${selectedTime.minute}";
    DateTime newDT = DateTime(
      dateTimeNow.year,
      dateTimeNow.month,
      dateTimeNow.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    setState(() {
      dateTimeNow = newDT;
    });
  }

  Future<void> _setReminder() async {
    if (_dateController.text.isEmpty || _timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a plant, date, and time'),
      ));
      return;
    }

    final date = _dateController.text;
    final time = _timeController.text;
    final dateTimeString = "$date $time";

    try {
      final parsedDateTime =
      DateFormat("yyyy/MM/dd HH:mm").parse(dateTimeString);
      await FirebaseFirestore.instance.collection('reminders').add({
        'plantName': selectTypeCateugore,
        'date': _dateController.text,
        'time': _timeController.text,
        'timestamp': parsedDateTime.millisecondsSinceEpoch,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Reminder set successfully'),
      ));
      showNotification();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to set reminder. Invalid date or time format.'),
      ));
    }
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
            top: 240,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 390,
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(88, 187, 128, 100),
                  border: Border.all(
                    color: Color.fromRGBO(88, 187, 128, 100),
                    width: 2,
                  ),
                ),
                child: StreamBuilder<List<String>>(
                  stream: categoriesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No categories available.",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return DropdownButtonFormField<String>(
                        alignment: Alignment.centerRight,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white12,
                              width: 0.15,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                        hint: selectTypeCateugore == null
                            ? Container(
                          child: Text(
                            " ",
                            textAlign: TextAlign.right,
                            style: TextStyle(),
                          ),
                        )
                            : Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(selectTypeCateugore.toString(),
                              style: TextStyle(
                                fontSize: 4,
                                color: Colors.black,
                              )),
                        ),
                        isExpanded: true,
                        items: snapshot.data!
                            .map(
                              (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                            .toList(),
                        borderRadius: BorderRadius.circular(10),
                        menuMaxHeight: 260,
                        onChanged: (valueSelcet) async {
                          setState(() {
                            selectTypeCateugore = valueSelcet;
                          });
                          print(selectTypeCateugore.toString());
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isDatePickerVisible = !_isDatePickerVisible;
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(88, 187, 128, 100),
                        border: Border.all(
                          color: Color.fromRGBO(88, 187, 128, 100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_ios),
                          Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isDatePickerVisible)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Date',
                          filled: true,
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate(_dateController);
                        },
                      ),
                    ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isTimePickerVisible = !_isTimePickerVisible;
                      });
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(88, 187, 128, 100),
                        border: Border.all(
                          color: Color.fromRGBO(88, 187, 128, 100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_ios),
                          Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isTimePickerVisible)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: 'Time',
                          filled: true,
                          suffixIcon:
                          Icon(Icons.access_time_outlined, size: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectTime(_timeController);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 680,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _setReminder,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(88, 187, 128, 100),
                        border: Border.all(
                          color: Color.fromRGBO(88, 187, 128, 100),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Set reminder',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 77, 59),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
}
