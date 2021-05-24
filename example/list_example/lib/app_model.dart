import 'package:binding/binding.dart';

class AppModel extends NotifyPropertyChanged {
  static const itemsPropertyName = 'items';
  List<String> _items;
  List<String> get items => _items;

  AppModel() : _items = [];

  addItem(String item) {
    _items.add(item);
    propertyChanged(propertyName: itemsPropertyName);
  }
}
