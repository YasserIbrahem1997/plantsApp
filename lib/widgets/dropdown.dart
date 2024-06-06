import 'dart:ffi';

import 'package:flutter/material.dart';

class DateDropdowns extends StatefulWidget {
  @override
  _DateDropdownsState createState() => _DateDropdownsState();
}

class _DateDropdownsState extends State<DateDropdowns> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDropdownButton('Year', _buildYearItems(), (int? value) {
          setState(() {
            selectedYear = value!;
          });
        }),
        _buildDropdownButton('Month', _buildMonthItems(), (int? value) {
          setState(() {
            selectedMonth = value!;
          });
        }),
        _buildDropdownButton('Day', _buildDayItems(), (int? value) {
          setState(() {
            selectedDay = value!;
          });
        }),
      ],
    );
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int year = 1900; year <= DateTime.now().year; year++) {
      items.add(DropdownMenuItem<int>(
        value: year,
        child: Text(year.toString()),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int month = 1; month <= 12; month++) {
      items.add(DropdownMenuItem<int>(
        value: month,
        child: Text(month.toString()),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildDayItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int day = 1; day <= 31; day++) {
      items.add(DropdownMenuItem<int>(
        value: day,
        child: Text(day.toString()),
      ));
    }
    return items;
  }

  Widget _buildDropdownButton(
    String hint, List<DropdownMenuItem<int>> items,
      void Function(int?)? onChanged) {
    return DropdownButton<int>(
  
      value: hint =='Year'
          ? selectedYear
          : hint == 'Month'
              ? selectedMonth
              : selectedDay,
      onChanged: onChanged,
      items: items,
    );
  }
  
  DropdownButtonStyle({required MaterialColor iconDisabledColor, required EdgeInsets padding, required int iconSize, required Alignment alignment, required EdgeInsets iconMargin, required Icon dropdownIcon, required Icon icon, required TextStyle disabledHintStyle, required Color dropdownColor, required int elevation, required TextStyle itemStyle}) {}
}
