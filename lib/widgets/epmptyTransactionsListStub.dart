import 'package:flutter/material.dart';

class EmptyTransactionsListStub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
            'Transactions list is empty',
            style: Theme.of(context).textTheme.titleLarge,
            // style: Theme.of(context).textTheme.bodyMedium
          )),
          SizedBox(height: 20,),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ))
        ],
      )
      ,
    );
  }
}
