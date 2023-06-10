import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expences/models/category.dart';

class ExpenceCategory extends StatelessWidget {
  Category category;

  ExpenceCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    String categoryText = category.categoryName;
    var categoryColor = int.parse(category.categoryData.entries.first.value);
   print(category.categoryName);
//    for (var colour in category.value.keys) {
//
//    }
    return Container(
      width: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(categoryColor),
//        color: Color(0xffffab40),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
        )
      ),
      child: Text(
        categoryText,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
//          style: const TextStyle()
      ),
    );
  }
}
