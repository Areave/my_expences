import 'package:flutter/material.dart';

import 'category.dart';

class Transaction {
  final String id;
  final String title;
  final DateTime date;
  final double expence;
  final Category category;

  Transaction(
      {required this.id,
      required this.date,
      required this.expence,
      required this.category,
      required this.title});
}
