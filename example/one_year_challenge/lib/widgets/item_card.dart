import 'package:flutter/material.dart';
import 'package:binding/binding.dart';
import '../model/item_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Color color;
  final Function onTap;

  ItemCard({this.item, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Binding<Item>(
      source: item,
      path: Item.countPropertyName,
      builder: (_, itemInstance) => InkWell(
        onTap: onTap,
        child: Container(
          color: color,
          child: Center(
            child: Text(itemInstance.count.toString()),
          ),
        ),
      ),
    );
  }
}
