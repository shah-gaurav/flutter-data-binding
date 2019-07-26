import 'item_model.dart';

class ItemProvider {
  Future<List<Item>> fetchItems() async {
    var returnList = List<Item>();
    await Future.delayed(Duration(seconds: 2), () {
      for (int i = 0; i < 20; i++) {
        returnList.add(Item());
      }
    });
    return returnList;
  }
}
