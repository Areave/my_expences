import 'dart:math';
import 'package:localstore/localstore.dart';
import 'package:my_expences/models/category.dart';
import 'dart:convert';
import '../models/transaction.dart';

class DataBaseService {

  final db = Localstore.instance;

  _myDateSerializer(dateObject) {
    if (dateObject is DateTime) {
      return dateObject.toIso8601String();
    }
    return dateObject;
  }

  getCollectionFromLocalStorage(String userName, String collectionName) {
    return db.collection(userName).doc(collectionName).get();
  }
  getUsernameDataFromLocalStorage(String userName) {
    db.collection(userName).get();
  }

  addInstanceToCollectionToDB(String userName, String collectionName, instance) {
    db.collection(userName).doc(collectionName).set({
      'data': instance
    }, SetOptions(merge: true));
  }

  saveCategoriesListToDB(String userName, List<Category> categoryList){
    db.collection(userName).doc('categories').set({
      'data': categoryList
    });
  }

  getCategoriesListFromDB(String userName) {
    return getCollectionFromLocalStorage(userName, 'categories');
  }

  clearUserCollectionsListFromDB(String userName) {
    //Очищать всего юзера?
    db.collection(userName).doc('categories').delete();
  }


  saveDefaultCategoriesListToDB(String userName) {

    Map<String, Map<String, String>> categoryList = {
      'food': {'color': '0xFFFFFF00'},
      'bars': {'color': '0xFFE65100'},
      'alco': {'color': '0xFFFF1744'},
      'medical': {'color': '0xFFEEEED9'},
      'rent': {'color': '0xFF9900FF'},
      'bills': {'color': '0xFFD9D2E9'},
      'taxi': {'color': '0xFFE69138'},
      'tech': {'color': '0xFFB6D7A8'},
      'calls': {'color': '0xFFD5A6BD'},
      'cloth': {'color': '0xFFE06666'},
      'saving': {'color': '0xFF93C47D'},
      'joy': {'color': '0xFF40C4FF'},
//    '---': {'color': '0xFFE91E63'},
//    '---': {'color': '0xFFCDDC39'},
    };

    List<Category> createCategoryList() {
      List<Category> list = [];
      categoryList.entries.forEach((entry) {

        for (int i = 0; i < 100; i++) {
          var g = pow(i, i);
          print(i);
        }

        var id = DateTime.now().millisecondsSinceEpoch;
        // var id = UniqueKey().toString();
        print(id);
        // print(id);

        var category = Category(id: id,
            categoryName: entry.key,
            categoryData: entry.value);

        list.add(category);
      });
      return list;
    }

    var list = createCategoryList();

    db.collection(userName).doc('categories').set({
      'data': list
    });
  }

  saveTransactionToDB(String userName, Transaction transaction) {

    Map<String, dynamic> toSet = {
      'title': transaction.title,
      'expence': transaction.expence,
      'category': json.encode(transaction.category),
      'date': json.encode(transaction.date, toEncodable: _myDateSerializer)
    };


    db.collection('transactions').doc('transactions').set(toSet);

    db.collection('transactions').get().then((value) {
      print('transactions:');
      print(value);
    });

    // final id = db.collection('transactions').doc().id;
    // print(id);
    // db
    //     .collection('transactions')
    //     .doc(id)
    //     .set({'title': transaction.title, 'done': false});
    //
    // db.collection('transactions').doc(id).get().then((value) {
    //   print('recent transaction:');
    //   print(value);
    // });
    //
    // db.collection('transactions').get().then((value) {
    //   print('transactions:');
    //   print(value);
    // });
  }

  static final DataBaseService _instance = DataBaseService();

  static DataBaseService get instance => _instance;
}
