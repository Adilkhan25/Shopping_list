import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';

class RestOperation {
  static final db = FirebaseFirestore.instance;
  static const collection = 'groceries';
  static void addItem(Map<String, dynamic> grocery) {
    try {
      db.collection(collection).add(grocery).then((DocumentReference doc) {
        print('Wow item added with id ${doc.id}');
      }).onError((e, _) {
        print('Item Can\'t be added because $e');
      });
    } catch (e) {
      print('Failed to add the item due to $e');
    }
  }

  static Future<List<GroceryItem>> getTheData() async {
    final List<GroceryItem> groceryList = [];
    try {
      final QuerySnapshot snapshot = await db.collection(collection).get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        var category = categories.values
            .firstWhere((value) => value.title == data['category']);
        groceryList.add(GroceryItem(
            id: doc.id,
            name: data['name']!,
            quantity: data['quantity'],
            category: category));
      }
      print('Data fetched successfully\n ${groceryList.join("\n")}');
    } catch (e) {
      print('Something went wrong while fetching the data due to $e');
    }
    return groceryList;
  }
}
