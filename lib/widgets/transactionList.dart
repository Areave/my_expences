import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_expences/widgets/epmptyTransactionsListStub.dart';
import '../models/transaction.dart';
import './transaction_card.dart';

class TransactionList extends StatelessWidget {
  List transactionsList;
  Function removeTransaction;
  Function openAddTransactionSheet;
  var mainContext;

  TransactionList(
      {required this.transactionsList,
      required this.removeTransaction,
      required this.openAddTransactionSheet,
      required this.mainContext});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: transactionsList.isEmpty
            ? EmptyTransactionsListStub()
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  // return ListTile(
                  //   title: Text(
                  //     transactionsList[index].title,
                  //     style: Theme.of(context).textTheme.bodyMedium,
                  //   ),
                  //   leading: CircleAvatar(
                  //     radius: 30,
                  //     child: FittedBox(
                  //       child: Text(transactionsList[index].expence.toString()),
                  //     ),
                  //   ),
                  // );
                  return TransactionCard(
                      transaction: transactionsList[index],
                      openAddTransactionSheet: openAddTransactionSheet,
                      removeTransaction: removeTransaction,
                      mainContext: mainContext);
                },

                // reverse: true,
                itemCount: transactionsList.length,
              ));
  }
}
