import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpenceAmount extends StatelessWidget {
  var expence;

  ExpenceAmount({this.expence});

  String getAmountString(expence) {
//    return '${expence}';
    return expence.toStringAsFixed(0);
//    return double.parse(expence).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.purple,
      )),
      width: 55,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.all(5),
      child: Text(getAmountString(expence),
      textAlign: TextAlign.center,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Colors.purple
      ),),
    );
  }
}
