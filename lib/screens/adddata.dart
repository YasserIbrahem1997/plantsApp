import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddData extends StatefulWidget {
  const AddData({key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController plantNameControllar = TextEditingController();
  TextEditingController plantScienteficControllar = TextEditingController();
  TextEditingController plantDescriptionControllar = TextEditingController();
  TextEditingController plantTypeControllar = TextEditingController();
  TextEditingController plantPricingControllar = TextEditingController();
  TextEditingController plantTemperetureControllar = TextEditingController();
  TextEditingController plantWateringControllar = TextEditingController();
  TextEditingController plantFretilizingControllar = TextEditingController();
  TextEditingController plantHumidityControllar = TextEditingController();
  // TextEditingController plantTemperatureControllar = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  List<Uint8List> _images = [];
  final picker = ImagePicker();
  List<String> _imageUrls = []; // to store download URLs of uploaded images


  Future<void> _selectDate(TextEditingController controller) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        setState(() {
          controller.text = picked
              .toLocal()
              .toString()
              .split(' ')[0]; // Formats date as yyyy-MM-dd
        });
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> _selectTime(TextEditingController controller) async {
    try {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null && mounted) {
        final now = DateTime.now();
        final dateTime =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        setState(() {
          controller.text = picked
              .format(context); // Formats time based on the device's locale
        });
      }
    } catch (e) {}
  }

  String? _selectedValueOptaion;
  String? _selectedValue;
  String? selectedValueLight;
  String? selectedValueDifficulty;
  String? selectedValueCleaning;
  String? selectedValuePlace;


  // Future getImage() async {
  //   // ignore: deprecated_member_use
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  String? groupValue = "yes";
  String? temperature = "now";
  String? cleaning = "no";
  @override
  void dispose() {
    _dateController.dispose();

    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 50,
            color: Color.fromARGB(255, 5, 77, 59),
            weight: 300,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Plant name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantNameControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Plant scientefic name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantScienteficControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'description',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantDescriptionControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantTypeControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Pricing',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantPricingControllar,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Flower color',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: _selectedValue == null
                      ? Container(
                      child: Text(
                        "select color",
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${_selectedValue.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                    'Red',
                    'Yellow',
                    'Green',
                    'Pink',
                    'white',
                    'orange',
                    'Violet',
                    'Blue',
                    'Purple',
                    'Multi Colors'
                  ]
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
                    _selectedValue = valueSelcet;
                    print(_selectedValue);
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Leaf color',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: _selectedValueOptaion == null
                      ? Container(
                      child: Text(
                        'Select an option',
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${_selectedValueOptaion.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                    'grey',
                    'Dark green',
                    'Green',
                    'variegated'
                        'white',
                  ]
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
                    _selectedValueOptaion = valueSelcet;
                    print(_selectedValueOptaion);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.red,
                    ),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         "صور المنتج ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _images.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                        height: 90,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Image.memory(
                                  _images[index],
                                  height: 80,
                                  width: 80,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color:
                                      Colors.deepOrange,
                                      borderRadius:
                                      BorderRadius
                                          .circular(50)),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _images.remove(
                                              _images[index]);
                                          _imageUrls.clear();
                                        });
                                      },
                                      child: const Icon(
                                          Icons.close,
                                          size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _imgFromGallery();
                          await _uploadImages(); // call the function to upload images to Firebase Storage// call the function to upload images to Firebase Storage
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: const Text(
                                    'تحميل الصور',
                                    style: TextStyle(
                                      decoration:
                                      TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        labelText: 'Date',
                        filled: true,
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectDate(_dateController);
                        print(_dateController);
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _startTimeController,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              labelText: 'Start Date',
                              filled: true,
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectTime(_startTimeController);
                              print(_startTimeController.text);
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            controller: _endTimeController,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              labelText: 'End Date',
                              filled: true,
                              suffixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectTime(_endTimeController);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Watering frequency',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantWateringControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Fertilizing Frequency',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantFretilizingControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Humidity',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantHumidityControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Temperature',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: plantTemperetureControllar,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 18)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Light needed to plant',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: selectedValueLight == null
                      ? Container(
                      child: Text(
                        "select Light",
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${selectedValueLight.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                    'Full sun',
                    'part sun',
                    'part shade',
                  ]
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
                    selectedValueLight = valueSelcet;
                    print(selectedValueLight);
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Difficulty',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: selectedValueDifficulty == null
                      ? Container(
                      child: Text(
                        "select Difficulty",
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${selectedValueDifficulty.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                    'Easy',
                    'Medium',
                    'Hard'
                  ]
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
                    selectedValueDifficulty = valueSelcet;
                    print(selectedValueDifficulty);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Cleaning',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: selectedValueCleaning == null
                      ? Container(
                      child: Text(
                        "select Cleaning",
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${selectedValueCleaning.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                    'Not Needed',
                    'leaves every third months ',
                    'leaves every second months ',
                  ]
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
                    selectedValueCleaning = valueSelcet;
                    print(selectedValueCleaning);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ), SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Text(
                  'Place',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.15,
                              style: BorderStyle.solid))),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w800),
                  hint: selectedValuePlace == null
                      ? Container(
                      child: Text(
                        "select Place",
                        textAlign: TextAlign.right,
                        style: TextStyle(),
                      ))
                      : Container(
                    child: Text(
                      "${selectedValuePlace.toString()}",
                      style: TextStyle(
                        fontSize: 4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  items: <String>[
                   "Indoor",
                   "Outdoor"
                  ]
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
                    selectedValuePlace = valueSelcet;
                    print(selectedValuePlace);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 50,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 43, 165, 120),
                      borderRadius: BorderRadius.circular(16)),
                  child: TextButton(
                    onPressed: () async {
                      await _uploadImages();
                     FirebaseFirestore.instance.collection("category").add({
                       "planetName":plantNameControllar.text,
                       "planetScientefic":plantScienteficControllar.text,
                       "planetDescriotion":plantDescriptionControllar.text,
                       "planetType":plantTypeControllar.text,
                       "plantPricing":plantPricingControllar.text,
                       "FlowerColor":_selectedValue,
                       "LeafColor":_selectedValueOptaion,
                       'imageUrls': _imageUrls,
                       'date': _dateController.text,
                       'StartDate': _startTimeController.text,
                       'EndDate': _endTimeController.text,
                       'wateringFrequency': plantWateringControllar.text,
                       'Fertilizing': plantFretilizingControllar.text,
                       'humidity': plantHumidityControllar.text,
                       'temperature': plantTemperetureControllar.text,
                       'lightNeeded': selectedValueLight,
                       'difficult': selectedValueDifficulty,
                       'cleaning': selectedValueCleaning,
                       'Place': selectedValuePlace,
                       'isFavorite': false,
                     }).then((value) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                         content: Text("Sending Data"),

                       ));
                        FirebaseFirestore.instance
                           .collection("category")
                           .doc(value.id)
                           .update({
                         "idPlants": value.id,
                       });
                        Navigator.pop(context);
                     });
                    },
                    child: Text(
                      'Add data',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
  void _imgFromGallery() async {
    List<XFile>? files = await picker.pickMultiImage(
      imageQuality: 50,
    );

    for (var element in files!) {
      _images.add(await element.readAsBytes());
    }

    setState(() {});
  }
  Future<void> _uploadImages() async {
    try {
      for (var imageBytes in _images) {
        // Generate a unique filename for each image (you may use UUID or any other unique identifier)
        String filename = DateTime.now().millisecondsSinceEpoch.toString();

        // Upload image to Firebase Storage
        await firebase_storage.FirebaseStorage.instance
            .ref('images/$filename.jpg')
            .putData(imageBytes);

        // Get the download URL of the uploaded image
        String downloadURL = await firebase_storage.FirebaseStorage.instance
            .ref('images/$filename.jpg')
            .getDownloadURL();

        // Save the download URL to the list
        _imageUrls.add(downloadURL);
      }
    } catch (e) {
      print('Error uploading images: $e');
      // Handle error, show a snackbar or toast, etc.
    }
  }

}
