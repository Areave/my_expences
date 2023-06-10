import 'package:flutter/material.dart';
import 'package:my_expences/widgets/chartBar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({required this.recentTransactions});

  List<Map<String, Object>> get chartBarDataList {
    // var totalWeekSum = 0.0;
    var totalWeekSum = recentTransactions.fold(0.0, (sum, transaction) {
      return sum += transaction.expence;
    });

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalDaySum = 0;

      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalDaySum += transaction.expence;
        }
      }

      double percentage = totalDaySum / totalWeekSum;

      return {
        'weekDay': DateFormat.E().format(weekDay),
        'amount': totalDaySum.toStringAsFixed(0),
        'percentage': percentage
      };
    }).reversed.toList() ;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Theme.of(context).colorScheme.primary)),
        elevation: 10,
        color: Colors.white70,
        child: recentTransactions.isEmpty
            ? null
            : Padding(
                padding: EdgeInsets.all(7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: chartBarDataList.map((data) {
                    return Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(chartBarData: data));
                  }).toList(),
                ),
              ));
  }
}
