import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/database/rest_operation.dart';
import 'package:shopping_list/models/category.dart';

class NewGroceryItem extends StatefulWidget {
  const NewGroceryItem({
    super.key,
  });

  @override
  State<NewGroceryItem> createState() => _NewGroceryItemState();
}

class _NewGroceryItemState extends State<NewGroceryItem> {
  final _formKey = GlobalKey<FormState>();

  var _enteredItemName = '';

  var _entertedQuantity = 1;

  Category? _enteredCategory;

  void _addItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final grocery = {
        'name': _enteredItemName,
        'quantity': _entertedQuantity,
        'category': _enteredCategory!.title,
      };
      RestOperation.addItem(grocery,null);
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                    label: Text('Enter the grocery name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 2 to 50 characteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredItemName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Enter the Quantity'),
                      ),
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        if (value == '0') {
                          return 'Quantity can\'t be zero';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _entertedQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: [
                        for (final category in categories.entries) ...{
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                ColoredBox(
                                  color: category.value.color,
                                  child: const SizedBox(
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                        }
                      ],
                      onChanged: (value) {},
                      hint: const Text('Select category'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select the category';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredCategory = Category(value!.title, value.color);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addItem(context);
                    },
                    child: const Text('Add item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
