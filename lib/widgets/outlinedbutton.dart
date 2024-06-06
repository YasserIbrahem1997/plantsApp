
import 'package:flutter/material.dart';
Map<String, bool> _buttonStates = {
  'BEGINNER': false,
  'OLD FELLOW': false,
  'PRO': false,
};

class ColoredOutlinedButton extends StatefulWidget {
  final String text;
  final bool isSelected;
final VoidCallback onSelect;

  const ColoredOutlinedButton(
    {Key? key, required this.text,
    required this.isSelected,
    required this.onSelect,}) : super(key: key);

  @override
  _ColoredOutlinedButtonState createState() => _ColoredOutlinedButtonState();
}

class _ColoredOutlinedButtonState extends State<ColoredOutlinedButton> {
  bool _isClicked = false;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _isClicked
              ? Colors.white
              : Colors.black, // Border color changes on click
        ),
        color: _isClicked
            ? Color(0xFF58BB80)
            : Colors.transparent, // Background color changes on click
      ),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _isClicked = !_isClicked; // Toggle clicked state
          });
        },
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isClicked
                ? Colors.black
                : Colors.black, // Text color changes on click
            fontSize: 13, fontWeight: FontWeight.bold
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.transparent, // Hide the default outline
          ),
        ),
      ),
    );
  }
}
// Method to set selected state for buttons in the row
void setStateForRow(String selectedButton) {
    // Remove the loop and use setState directly
    // Set state based on the selected button
    _buttonStates.forEach((buttonName, isSelected) {
      _buttonStates[buttonName] = buttonName == selectedButton;
    });
  }


