import 'package:flutter/widgets.dart';

abstract class NotifyPropertyChanged {
  Key key = UniqueKey();
  void Function({@required String propertyName, @required Key key}) callback;

  void propertyChanged({@required String propertyName}) {
    if (callback != null) {
      callback(propertyName: propertyName, key: key);
    }
  }
}
