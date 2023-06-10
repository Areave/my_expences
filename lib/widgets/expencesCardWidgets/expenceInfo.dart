import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'expenceCategory.dart';
import 'expenceDate.dart';
import 'expenceTitle.dart';

class ExpenceInfo extends StatelessWidget {
  var date;
  var title;
  var category;

  ExpenceInfo({
    this.title,
    this.category,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: ExpenceTitle(title: title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExpenceDate(date: date),
              ExpenceCategory(category: category)
            ],
          )
        ],
      ),
    ));
  }
}