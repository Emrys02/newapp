import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      int amountSum = 0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          amountSum += recentTransaction[i].price;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'price': amountSum
      };
    }).reversed.toList();
  }

  int get totalSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item['price'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    return recentTransaction.isEmpty == false
        ? Card(
            color: Theme.of(context).primaryColor,
            margin: const EdgeInsets.all(20),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ...groupedTransactionValues.map(
                    (data) {
                      return Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                            label: (data['day'].toString()),
                            amountspent: data['price'] as int,
                            dailypercentageoftotal:
                                ((data['price'] as int) / totalSpending)),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(top: 30),
            child: const SizedBox(
              height: 200,
              child: Text('Chart Is Not Available'), //Image.asset('images/use.png'),
            ),
          );
  }
}
