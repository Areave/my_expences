import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenceDate extends StatelessWidget {
  var date;

  ExpenceDate({this.date});

  // void printDateFormats() {
  //   var date = DateTime.now();
  //   print(DateFormat.d().format(date));
  //   print('d');
  //   print(DateFormat.E().format(date));
  //   print('E');
  //   print(DateFormat.EEEE().format(date));
  //   print('EEEE');
  //   print(DateFormat.LLL().format(date));
  //   print('LLL');
  //   print(DateFormat.LLLL().format(date));
  //   print('LLLL');
  //   print(DateFormat.M().format(date));
  //   print('M');
  //   print(DateFormat.Md().format(date));
  //   print('Md');
  //   print(DateFormat.MEd().format(date));
  //   print('MEd');
  //   print(DateFormat.MMM().format(date));
  //   print('MMM');
  //   print(DateFormat.MMMd().format(date));
  //   print('MMMd');
  //   print(DateFormat.MMMEd().format(date));
  //   print('MMMEd');
  //   print(DateFormat.MMMM().format(date));
  //   print('MMMM');
  //   print(DateFormat.MMMMd().format(date));
  //   print('MMMMd');
  //   print(DateFormat.MMMMEEEEd().format(date));
  //   print('MMMMEEEEd');
  //   print(DateFormat.QQQ().format(date));
  //   print('QQQ');
  //   print(DateFormat.QQQQ().format(date));
  //   print('QQQQ');
  //   print(DateFormat.y().format(date));
  //   print('y');
  //   print(DateFormat.yM().format(date));
  //   print('yM');
  //   print(DateFormat.yMd().format(date));
  //   print('yMd');
  //   print(DateFormat.yMEd().format(date));
  //   print('yMEd');
  //   print(DateFormat.yMMM().format(date));
  //   print('yMMM');
  //   print(DateFormat.yMMMd().format(date));
  //   print('yMMMd');
  //   print(DateFormat.yMMMEd().format(date));
  //   print('yMMMEd');
  //   print(DateFormat.yMMMM().format(date));
  //   print('yMMMM');
  //   print(DateFormat.yMMMMd().format(date));
  //   print('yMMMMd');
  //   print(DateFormat.yMMMMEEEEd().format(date));
  //   print('yMMMMEEEEd');
  //   print(DateFormat.yQQQ().format(date));
  //   print('yQQQ');
  //   print(DateFormat.yQQQQ().format(date));
  //   print('yQQQQ');
  //   print(DateFormat.H().format(date));
  //   print('H');
  //   print(DateFormat.Hm().format(date));
  //   print('Hm');
  //   print(DateFormat.Hms().format(date));
  //   print('Hms');
  //   print(DateFormat.j().format(date));
  //   print('j');
  //   print(DateFormat.jm().format(date));
  //   print('jm');
  //   print(DateFormat.jms().format(date));
  //   print('jms');
  // }

  String getStringDate(DateTime date) {
    var dateString;
//    var format = DateFormat('dd.mm').format(date);
    var format = DateFormat.MMMMEEEEd().format(date);
    dateString = format;
//    return '${date.day}.${date.month}.';
    return dateString;
  }

  @override
  Widget build(BuildContext context) {
//    printDateFormats();
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(5),
      child: Text(
        getStringDate(date),
//        enabled: false,

        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
