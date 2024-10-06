import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryList = [];
  void _addNewGroceryItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewGroceryItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        _groceryList.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your groceries'),
      ),
      body: _groceryList.isEmpty
          ? const Center(
              child: Text(
                  'No Groceries are available, please add the grocery item.\nTo add the grocery item press the + icon button'),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: ListView.builder(
                  itemCount: _groceryList.length,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      leading: ColoredBox(
                        color: _groceryList[idx].category.color,
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                      ),
                      title: Text(_groceryList[idx].name),
                      trailing: Text(_groceryList[idx].quantity.toString()),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addNewGroceryItem,
          tooltip: 'Add new grocery item',
          child: const Icon(Icons.add)),
    );
  }
}
