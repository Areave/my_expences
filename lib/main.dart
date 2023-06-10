import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:my_expences/models/category.dart';
import 'package:my_expences/services/dataBaseService.dart';
import 'package:my_expences/services/mongoDBService.dart';
import 'package:my_expences/widgets/sideMenu.dart';

import './widgets/addExpenceSheet.dart';
import './widgets/chart.dart';
import './widgets/transactionList.dart';
import './models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Watcher App',
      theme: ThemeData(
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
              titleMedium:
              TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              labelLarge: TextStyle(color: Colors.white70)),
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 25,
            ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePageState extends State<MyHomePage> {
  final title;
  final dataBaseSeviceInstance = DataBaseService.instance;
  final userName = 'igor2023';
  final collectionName = 'categories';

  MyHomePageState({this.title});

  late List<Category> _categoryList =  [Category(id: 0, categoryName: 'default', categoryData: {
  'color': '0xFFFFFF'
  })];

  List<Transaction> _transactionsList = [];

  List<Transaction> get _recentTransactions {
    return _transactionsList.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void setNewTransactionList(List<Transaction> newTransactionList) {
    newTransactionList.sort((tr1, tr2) => tr1.date.compareTo(tr2.date));
    setState(() {
      _transactionsList = newTransactionList;
    });
  }

  void addTransaction(Transaction transaction) {
    List<Transaction> newTransactionList = new List.from(_transactionsList);
    newTransactionList.add(transaction);
    // newTransactionList.insert(0, transaction);
    setNewTransactionList(newTransactionList);

    // dataBaseSeviceInstance.saveCategoriesListToDB();
    // dataBaseSeviceInstance.getCategoriesListFromDB().then((value) {
    //   print('categories:');
    //   print(value!.entries.length);
    //   print(value.entries);
    // });
    // dataBaseSeviceInstance.addCategoryToBD(Category(id: 1, categoryName: 'categoryName', categoryData: {'color': '23423'}));
  }

  void removeTransaction(transactionId) {
    List<Transaction> newTransactionList = new List.from(_transactionsList);
    List<Transaction> newTransactionList2 = newTransactionList
        .where((Transaction element) => element.id != transactionId)
        .toList();
    setNewTransactionList(newTransactionList2);
  }

  void updateTransaction(transaction, newTransaction) {
    List<Transaction> newTransactionList = new List.from(_transactionsList);
    int index = newTransactionList.indexOf(transaction);
    newTransactionList.remove(transaction);
    newTransactionList.insert(index, newTransaction);
    setNewTransactionList(newTransactionList);
  }

  void openAddTransactionSheet(context, Transaction? transaction) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builderContext) {
//          print(categoryList);
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: AddExpenceSheet(
              addTransaction: addTransaction,
              categoryList: _categoryList,
              transaction: transaction,
              updateTransaction: updateTransaction,
            ),
          );
        });
  }

  Map<String, Map> createCategoryListFromDBData(Map<String, dynamic> data) {
    Map<String, Map> result = {};

    data.entries.forEach((entry) {
      var key = entry.key.substring(12);
      var newValue = Map.from(entry.value);
      result[key] = newValue;
    });

    return result;
  }

  void addNewCategory(){
    var newCat = Category(id: 0, categoryName: 'default0', categoryData: {
      'color': '0xFFFFFF'
    });



    setState(() {
      _categoryList.add(newCat);
    });

    dataBaseSeviceInstance.saveCategoriesListToDB(userName, _categoryList);

    dataBaseSeviceInstance.getCategoriesListFromDB(userName).then((data){
      if(data != null) {
        var list = data['data'];
        print(list.last.categoryName);
      }
    });
  }

  void updateCategory(){

    // var categoryToUpdate = _categoryList.first;
    //
    // categoryToUpdate.categoryName = categoryToUpdate.categoryName + '00';
    //
    //
    //
    // setState(() {
    //   _categoryList.remove(categoryToRemove);
    // });

    dataBaseSeviceInstance.saveCategoriesListToDB(userName, _categoryList);

    dataBaseSeviceInstance.getCategoriesListFromDB(userName).then((data){
      if(data != null) {
        var list = data['data'];
        list.forEach((Category category){
          print(category);
        });
      }
    });
  }

  void printMongoCollection() async {
    var connection = DBConnection.getInstance();
    var db = await connection.getConnection();
    var collection = await db.collection('neighborhoods');
    var list = await collection.find({'name': 'Midwood'}).toList();
    print(list);
  }

  void removeCategory(){
    var categoryToRemove = _categoryList.first;

    setState(() {
      _categoryList.remove(categoryToRemove);
    });

    dataBaseSeviceInstance.saveCategoriesListToDB(userName, _categoryList);

    dataBaseSeviceInstance.getCategoriesListFromDB(userName).then((data){
      if(data != null) {
        var list = data['data'];
        print(list.last.categoryName);
      }
    });
  }

   void initState() {

    super.initState();


    dataBaseSeviceInstance.clearUserCollectionsListFromDB(userName);
    dataBaseSeviceInstance.saveDefaultCategoriesListToDB(userName);
    dataBaseSeviceInstance.getCategoriesListFromDB(userName).then((data){
      if(data != null) {
        var list = data['data']! as List<Category>;
        list.sort((category_a, category_b){
          return category_a.categoryName.compareTo(category_b.categoryName);
        });
        print(list.first.categoryName);
        _categoryList = list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              onPressed: () => openAddTransactionSheet(context, null),
              icon: Icon(Icons.add))
        ],
//        toolbarTextStyle: ThemeData.light().textTheme.copyWith().bodyMedium,
//        titleTextStyle: ThemeData.light().textTheme.copyWith().titleSmall,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(
                transactionsList: _transactionsList,
                removeTransaction: removeTransaction,
                openAddTransactionSheet: openAddTransactionSheet,
                mainContext: context),
            ElevatedButton(onPressed: printMongoCollection, child: Text('do stuff'))
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState(title: 'Money Watcher');
  }
}
