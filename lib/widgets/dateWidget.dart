import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateWidgetState();
  }
}

class DateWidgetState extends State<DateWidget> {
  void onDateTap(BuildContext context) {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onDateTap(context),
        child: Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.all(5),
          child: const Text(
            'text',
//        enabled: false,
            style: TextStyle(color: Colors.black),
          ),
        )
    );
  }
}
