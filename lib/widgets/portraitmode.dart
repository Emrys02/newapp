import 'package:flutter/material.dart';

import 'chart.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class PortraitMode extends StatelessWidget {
  final List<Transaction> data;
  final List<Transaction> recentTransactions;
  final AppBar appbar;
  final Function deleteTransaction;

  PortraitMode(
      {required this.data,
      required this.appbar,
      required this.recentTransactions,
      required this.deleteTransaction,});
  @override
  Widget build(BuildContext context) {
    final deviceproperties = MediaQuery.of(context);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: (deviceproperties.size.height -
                  appbar.preferredSize.height -
                  deviceproperties.padding.top) *
              0.35,
          child: Chart(recentTransactions),
        ),
        SizedBox(
          height: (deviceproperties.size.height -
                  appbar.preferredSize.height -
                  deviceproperties.padding.top) *
              0.65,
          child: TransactionList(data, deleteTransaction),
        ),
      ],
    );
  }
}
