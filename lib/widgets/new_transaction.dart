import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _newtransaction;

  const NewTransaction(this._newtransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _chosendate = DateTime.now();

  void submitData() {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = int.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0) {
      return;
    }

    widget._newtransaction(_enteredTitle, _enteredAmount, _chosendate);

    Navigator.of(context).pop();
  }

  _selectdate() {
    setState(() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.utc(2022, 1, 1),
              lastDate: DateTime.now())
          .then((value) {
        if (value == null) {
          return;
        } else {
          _chosendate = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                          'Picked date: ${DateFormat.yMMMEd().format(_chosendate)}')),
                  TextButton(
                    onPressed: () => {_selectdate()},
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              child: const Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
