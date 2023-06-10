import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './expencesCardWidgets/expenceAmount.dart';
import './expencesCardWidgets/expenceInfo.dart';

class TransactionCard extends StatelessWidget {
  var id;
  var date;
  var expence;
  var title;
  var category;
  var removeTransaction;
  var openAddTransactionSheet;
  var transaction;
  var mainContext;

  TransactionCard(
      {required this.transaction,
      required this.openAddTransactionSheet,
      required this.removeTransaction,
      required this.mainContext}) {
    id = transaction.id;
    date = transaction.date;
    expence = transaction.expence;
    title = transaction.title;
    category = transaction.category;
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            'remove transaction?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yep'),
              onPressed: () =>
                  {removeTransaction(id), Navigator.of(context).pop()},
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openAddTransactionSheet(mainContext, transaction),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Theme.of(context).primaryColorLight, width: 2)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                ExpenceAmount(expence: expence),
                ExpenceInfo(title: title, date: date, category: category),
                IconButton(
                    onPressed: () => removeTransaction(id),
                    color: Colors.red,
                    iconSize: 40,
                    icon: Icon(Icons.remove_circle)),
//              ElevatedButton(onPressed: () => _dialogBuilder(context), child: Text('remove')),
              ],
            ),
          )),
    );
  }
}
