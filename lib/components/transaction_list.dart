import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.onRemove, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (cxt, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('dd MMM y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          label: const Text('Excluir'),
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).errorColor,
                          ),
                          onPressed: () => onRemove(tr.id),
                          icon: const Icon(Icons.delete),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
            });
  }
}
