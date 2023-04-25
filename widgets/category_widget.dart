import 'package:flutter/material.dart';

class SimpleDropDownTextField extends StatefulWidget {
  @override
  _SimpleDropDownTextFieldState createState() => _SimpleDropDownTextFieldState();
}

class _SimpleDropDownTextFieldState extends State<SimpleDropDownTextField> {
  final _controller = TextEditingController();
  late String _selectedValue;

  final List<String> _dropdownItems = [    'Item 1',    'Item 2',    'Item 3',    'Item 4',    'Item 5',  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Select an item',
        border: OutlineInputBorder(),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _showDropdown(context);
      },
    );
  }

  void _showDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an item'),
          content: DropdownButton<String>(
            value: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
                _controller.text = value;
              });
              Navigator.of(context).pop();
            },
            items: _dropdownItems
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
