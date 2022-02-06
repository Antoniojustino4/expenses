import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  final Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Valor (R\$)',
                  )),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        // ignore: unnecessary_null_comparison
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Theme.of(context).textTheme.button!.color,
                      ),
                      child: const Text('Nova Transação'),
                      onPressed: _submitForm)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
