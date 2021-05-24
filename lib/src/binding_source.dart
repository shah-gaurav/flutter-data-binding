import 'package:flutter/widgets.dart';

import 'notify_property_changed.dart';

class BindingSource<T extends NotifyPropertyChanged> extends InheritedWidget {
  final T instance;
  final void Function(T) initialize;

  BindingSource(
      {Key key,
      @required this.instance,
      @required Widget child,
      this.initialize})
      : super(key: key, child: child) {
    if (initialize != null) {
      initialize(instance);
    }
  }

  @override
  bool updateShouldNotify(_) => false;

  static T of<T extends NotifyPropertyChanged>(BuildContext context) {
    BindingSource<T> provider = context
        .getElementForInheritedWidgetOfExactType<BindingSource<T>>()
        ?.widget;
    return provider?.instance;
  }
}
