import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addNewGroceryItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewGroceryItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your groceries'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (ctx, idx) {
              return ListTile(
                leading: ColoredBox(
                  color: groceryItems[idx].category.color,
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                ),
                title: Text(groceryItems[idx].name),
                trailing: Text(groceryItems[idx].quantity.toString()),
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
