import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});
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
    );
  }
}
