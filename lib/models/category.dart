import 'dart:convert';

class Category {
  final int id;
  final String categoryName;
  final Map<String, String> categoryData;
  final jsonEncoder = JsonEncoder();


  Category(
      {required this.id,
      required this.categoryName,
      required this.categoryData});

  fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        categoryName: json['categoryName'],
        categoryData: json['categoryData']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'categoryName': categoryName.toString(),
      'categoryData': jsonEncoder.convert(categoryData),
    };
  }

  @override
  String toString() {
    return '${this.id}, ${this.categoryName}, ${this.categoryData['color']}';
  }

}
