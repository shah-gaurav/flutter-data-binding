import 'package:binding/binding.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';
import 'item_provider.dart';

class MainModel extends NotifyPropertyChanged {
  static const itemsPropertyName = 'items';
  static const detailedColorPropertyName = 'detailedColor';
  static const detailedIndexPropertyName = 'detailedIndex';

  final itemProvider = ItemProvider();

  List<Item>? items;
  Color? detailedColor; // The color of the tapped card from the ListView
  int? detailedIndex; // The index of the tapped card from the ListView

  void getItems() async {
    items = await itemProvider.fetchItems();

    propertyChanged(propertyName: itemsPropertyName);
  }

  void showDetailed(Color color, int index) {
    detailedColor = color;
    detailedIndex = index;

    propertyChanged(propertyName: detailedColorPropertyName);
    propertyChanged(propertyName: detailedIndexPropertyName);
  }
}
