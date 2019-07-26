import 'package:flutter/material.dart';
import 'package:data_binding/data_binding.dart';
import '../model/main_model.dart';
import 'item_card.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Binding<MainModel>(
        source: BindingSource.of<MainModel>(context),
        path: MainModel.detailedIndexPropertyName,
        builder: (_, mainModel) => mainModel.detailedIndex == null
            ? Container()
            : SizedBox(
                width: 200,
                height: 200,
                child: ItemCard(
                  item: mainModel.items[mainModel.detailedIndex],
                  color: mainModel.detailedColor,
                  onTap: () =>
                      mainModel.items[mainModel.detailedIndex].incrementCount(),
                ),
              ),
      ),
    );
  }
}
