import 'package:flutter/material.dart';
import 'package:newapp/widgets/landscapemode.dart';

import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/portraitmode.dart';

void main() => runApp(_MyApp());

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.purple,
      ),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final List<Transaction> _data = [
    Transaction(
      id: 't1',
      item: 'New Shoes',
      price: 6999,
      date: DateTime.utc(2022, 1, 30),
    ),
    Transaction(
      id: 't2',
      item: 'Weekly Groceries',
      price: 1653,
      date: DateTime.utc(2022, 1, 31),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _data.where((trx) {
      return trx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String item, int price, DateTime date) {
    final _newtransaction = Transaction(
      item: item,
      price: price,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _data.add(_newtransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  _deleteTransaction(String id) {
    setState(() {
      _data.removeWhere((transaction) => transaction.id == id);
    });
  }

  final bool _showchart = false;
  @override
  Widget build(BuildContext context) {
    final deviceproperties = MediaQuery.of(context);
    final portraitmode = deviceproperties.orientation == Orientation.portrait;
    final landscapemode = deviceproperties.orientation == Orientation.landscape;

    final appbar = AppBar(
      title: const Text('Personal Expenses'),
      backgroundColor: Theme.of(context).primaryColorLight,
      elevation: 5,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (portraitmode)
              PortraitMode(
                appbar: appbar,
                data: _data,
                deleteTransaction: _deleteTransaction,
                recentTransactions: _recentTransactions,
              ),
            if (landscapemode)
              LandscapeMode(
                appbar: appbar,
                data: _data,
                deleteTransaction: _deleteTransaction,
                recentTransactions: _recentTransactions,
                showchart: _showchart,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
