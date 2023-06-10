import 'package:flutter/material.dart';
import 'package:my_expences/models/transaction.dart';

class ChartBar extends StatelessWidget {
  var chartBarData;
  double spendingPercentage = 0;

  ChartBar({this.chartBarData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(chartBarData['amount']),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 15,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: chartBarData['percentage'],
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(chartBarData['weekDay'])
      ],
    );
  }
}
