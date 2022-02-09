import 'package:flutter/material.dart';

import 'chart.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class LandscapeMode extends StatefulWidget {
  final List<Transaction> data;
  final List<Transaction> recentTransactions;
  final AppBar appbar;
  final Function deleteTransaction;
  bool showchart;

  LandscapeMode(
      {required this.data,
      required this.appbar,
      required this.recentTransactions,
      required this.deleteTransaction,
      required this.showchart});

  @override
  State<LandscapeMode> createState() => _LandscapeModeState();
}

class _LandscapeModeState extends State<LandscapeMode> {

  @override
  Widget build(BuildContext context) {
    final deviceproperties = MediaQuery.of(context);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Container(
              height: (deviceproperties.size.height -
                      widget.appbar.preferredSize.height -
                      deviceproperties.padding.top) *
                  0.2,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text('Show Chart'),
                  ),
                  Switch(
                      value: widget.showchart,
                      onChanged: (val) {
                        setState(() {
                          widget.showchart = val;
                        });
                      }),
                ],
              ),
            ),
            Row(
              children: [
                if (widget.showchart)
                  SizedBox(
                    height: (deviceproperties.size.height -
                            widget.appbar.preferredSize.height -
                            deviceproperties.padding.top) *
                        0.8,
                    child: Chart(widget.recentTransactions),
                    width: (deviceproperties.size.width * 0.4),
                  ),
                SizedBox(
                  height: (deviceproperties.size.height -
                          widget.appbar.preferredSize.height -
                          deviceproperties.padding.top) *
                      0.8,
                  child: TransactionList(widget.data, widget.deleteTransaction),
                  width: widget.showchart
                      ? (deviceproperties.size.width * 0.6)
                      : (deviceproperties.size.width * 1),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
