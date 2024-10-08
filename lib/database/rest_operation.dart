import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'dart:developer' as developer;

class RestOperation {
  static final db = FirebaseFirestore.instance;
  static const collection = 'groceries';
  static String addItem(Map<String, dynamic> grocery) {
    var itemId = DateTime.now().toString();
    try {
      
        db.collection(collection).add(grocery).then((DocumentReference doc) {
          developer.log(
            'Item added successfully with id  ${doc.id}',
            level: 0,
            stackTrace: StackTrace.current,
          );
          itemId = doc.id;
        }).onError((e, _) {
          developer.log(
            'Failed to add the item due to $e',
            level: 2,
            stackTrace: StackTrace.current,
          );
        });
      
    } catch (e) {
      developer.log(
        'Failed to add the item due to $e',
        level: 2,
        stackTrace: StackTrace.current,
      );
    }
    return itemId;
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
      developer.log(
        'data fetched successfully, total item in the list is: ${groceryList.length}',
        level: 0,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      developer.log(
        'Something went wrong while fetching the data due to $e',
        level: 2,
        stackTrace: StackTrace.current,
      );
    }
    return groceryList;
  }

  static void delete(String id) async {
    try {
      await db.collection(collection).doc(id).delete();
      developer.log(
        'Item deleted successfully! with id $id',
        level: 0,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      developer.log(
        'Something went wrong while deleting the data due to $e',
        level: 2,
        stackTrace: StackTrace.current,
      );
    }
  }
}
