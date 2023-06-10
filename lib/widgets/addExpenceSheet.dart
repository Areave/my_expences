import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/transaction.dart';

class AddExpenceSheet extends StatefulWidget {
  Function? addTransaction;

  // Map<String, Map> categoryList;
  List<Category> categoryList = [Category(id: 0, categoryName: 'default', categoryData: {
    'color': '0xFFFFFF'
  })];
  Transaction? transaction;
  Function? updateTransaction;

  AddExpenceSheet(
      {this.addTransaction,
      required this.categoryList,
      this.transaction,
      this.updateTransaction});

  @override
  State<StatefulWidget> createState() {
    return AddExpenceSheetState();
  }
}

class AddExpenceSheetState extends State<AddExpenceSheet> {
  Function? addTransaction;
  Function? updateTransaction;
  Transaction? transaction;
  late List<Category> categoryList;
  late Category initCategory;

  // MapEntry<String, Map> initCategory = ({
  //   '1685453979250': {'categoryName': 'alco', 'categoryData': {'color': '0xFFFF1744'}}
  // }).entries.toList().first;
  List<DropdownMenuItem> dropdownMenuItemsList = [];
  late DateTime chosenDate = DateTime.now();

//  late Map<String, Map> categoryList;

  AddExpenceSheetState();

  @override
  void initState() {
    categoryList = widget.categoryList;
    transaction = widget.transaction;
    updateTransaction = widget.updateTransaction;
    addTransaction = widget.addTransaction;
    initCategory = categoryList.first;
    dropdownMenuItemsList = createListForDropDownButton(categoryList);

    if (transaction != null) {
      titleController.text = transaction!.title;
      amountController.text = '${transaction!.expence}';
      dateController.text = transaction!.date.toString();
      chosenDate = transaction!.date;
      initCategory = transaction!.category;
    }

    super.initState();
  }

  final titleController = TextEditingController(text: 'initTitle');
  final amountController = TextEditingController(text: '20');
  final dateController = TextEditingController(text: 'mockDate');

  List<DropdownMenuItem> createListForDropDownButton(
      List<Category> categoryList) {
    // List<DropdownMenuItem> arr = [];
    return categoryList
        .map((Category category) => DropdownMenuItem(
            value: category, child: Text(category.categoryName)))
        .toList();
  }

  // return arr;

  bool isInputDataValid(String date, String expence, String title) {
    return !date.isEmpty && !expence.isEmpty && !title.isEmpty;
  }

  void onCategoryChange(value) {
    var chosenCategory = initCategory;
    for (var category in categoryList) {
      if (category.id == value.id) {
        chosenCategory = category;
        setState(() {
          initCategory = chosenCategory;
        });
        return;
      }
    }
  }

  void submitHandler() {
    if (!isInputDataValid(
        dateController.text, amountController.text, titleController.text)) {
      return;
    }

    var title = titleController.text;
    var expence = double.parse(amountController.text);
    // var date = DateTime.now().subtract(Duration(days: Random().nextInt(7) - 1));
    var date = chosenDate == null ? DateTime.now() : chosenDate;
    var category = initCategory;
    var id = transaction == null
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : transaction?.id;

    var newTransaction = Transaction(
        id: id!,
        date: date,
        expence: expence,
        category: category,
        title: title);

    if (transaction != null) {
      updateTransaction!(transaction, newTransaction);
    } else {
      addTransaction!(newTransaction);
    }

    Navigator.pop(context);
  }

  void showMyDatePicker() {
    showDatePicker(
            context: context,
            initialDate: chosenDate,
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        dateController.text = value.toString();
        setState(() {
          chosenDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(initCategory.categoryName);
    print(initCategory);

    return Card(
        child: Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  // flex: 5,
//                padding: EdgeInsets.all(4),
                  child: Container(
                padding: EdgeInsets.all(3),
                child: TextField(
                  onSubmitted: (_) => submitHandler(),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'title'),
                  controller: titleController,
                ),
              )),
              Expanded(
                // flex: 5,
//                padding: EdgeInsets.all(4),
                child: Container(
                  padding: EdgeInsets.all(3),
                  child: TextField(
                    onSubmitted: (_) => submitHandler(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'amount'),
                    controller: amountController,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(4),
              //     child: TextField(
              //       onSubmitted: (_) => submitHandler(),
              //       decoration: const InputDecoration(
              //           border: OutlineInputBorder(), labelText: 'date'),
              //       controller: dateController,
              //     ),
              //   ),
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: showMyDatePicker,
                  child: Text(
                    chosenDate == null
                        ? 'choose date'
                        : DateFormat.yMd().format(chosenDate),
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.labelLarge?.color),
                  )),
              DropdownButton(
                value: initCategory,
                items: dropdownMenuItemsList,
                onChanged: (value) {
                  onCategoryChange(value);
                },
              ),
              IconButton(
                iconSize: 40,
                color: Colors.blueGrey,
                icon: Icon(transaction == null
                    ? Icons.add_circle_outline_rounded
                    : Icons.edit),
                onPressed: submitHandler,
              )
            ],
          )
        ],
      ),
    ));
  }
}
