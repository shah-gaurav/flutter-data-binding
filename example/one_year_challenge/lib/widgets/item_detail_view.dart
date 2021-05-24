import 'package:binding/binding.dart';
import 'package:flutter/material.dart';

import '../model/main_model.dart';
import 'item_card.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Binding<MainModel>(
        source: BindingSource.of<MainModel>(context),
        path: MainModel.detailedIndexPropertyName,
        builder: (_, mainModel) => getDetailedView(mainModel),
      ),
    );
  }

  getDetailedView(MainModel mainModel) {
    final items = mainModel.items;
    final index = mainModel.detailedIndex;
    final color = mainModel.detailedColor;
    if (items == null || index == null || color == null) {
      return Container();
    }
    return SizedBox(
      width: 200,
      height: 200,
      child: ItemCard(
        item: items[index],
        color: color,
        onTap: () => items[index].incrementCount(),
      ),
    );
  }
}
