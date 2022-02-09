import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int amountspent;
  final double dailypercentageoftotal;

  const ChartBar(
      {required this.amountspent,
      required this.dailypercentageoftotal,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 40,
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.1,
                child: FittedBox(
                  child: Text(
                    '#$amountspent',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    FractionallySizedBox(
                      heightFactor: dailypercentageoftotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              SizedBox(height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(label, style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            ],
          ),
        );
      },
    );
  }
}
