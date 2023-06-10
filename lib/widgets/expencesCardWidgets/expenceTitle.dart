import 'package:flutter/material.dart';

class ExpenceTitle extends StatelessWidget {
  var title;

  ExpenceTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
//      style: const TextStyle(
//        fontFamily: 'Quicksand',

//      ),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            letterSpacing: 1.6, fontSize: 22, fontWeight: FontWeight.bold));
  }
}
