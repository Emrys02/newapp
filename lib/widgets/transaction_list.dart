import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _data;
  final Function _deleteTransaction;

  const TransactionList(this._data, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _data.isEmpty == false
        ?   ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 8,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text("#${_data[index].price}"),
                        ),
                      ),
                    ),
                    title: Text(_data[index].item, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                    trailing:
                    MediaQuery.of(context).size.width < 400 ?
                    IconButton(
                      onPressed: ()=>_deleteTransaction(_data[index].id),
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: Theme.of(context).errorColor,
                        ))
                    :TextButton.icon(onPressed: ()=>_deleteTransaction(_data[index].id), icon: Icon(
                        Icons.delete_forever_rounded,
                        color: Theme.of(context).errorColor,), 
                        label: const Text('Delete', style: TextStyle(color: Colors.red),),),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(_data[index].date), 
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                );
              },
              itemCount: _data.length,
            )
        : Container(
            margin: const EdgeInsets.only(top: 40),
            child: const Center(
              child: Text(
                'No Entry',
                style: TextStyle(fontSize: 40),
              ),
            ),
          );
  }
}
