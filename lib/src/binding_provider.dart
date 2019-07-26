import 'package:flutter/widgets.dart';

import 'binding_base.dart';

class BindingProvider extends InheritedWidget {
  final _instancesToNotify = Map<String, List<BindingBase>>();

  BindingProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static Type _typeOf<T>() => T;

  static BindingProvider of(BuildContext context) {
    final type = _typeOf<BindingProvider>();
    final provider = context
        .ancestorInheritedElementForWidgetOfExactType(type)
        ?.widget as BindingProvider;

    return provider;
  }

  void add(String rebuildWhenPropertyChanged, BindingBase instanceToAdd) {
    if (!_instancesToNotify.containsKey(rebuildWhenPropertyChanged)) {
      _instancesToNotify[rebuildWhenPropertyChanged] = List<BindingBase>();
    }
    if (!_instancesToNotify[rebuildWhenPropertyChanged]
        .contains(instanceToAdd)) {
      instanceToAdd.source.callback = propertyChanged;
      _instancesToNotify[rebuildWhenPropertyChanged].add(instanceToAdd);
    }
  }

  void remove(String rebuildWhenPropertyChanged, BindingBase instanceToRemove) {
    if (!_instancesToNotify.containsKey(rebuildWhenPropertyChanged)) {
      return;
    }
    if (_instancesToNotify[rebuildWhenPropertyChanged]
        .contains(instanceToRemove)) {
      _instancesToNotify[rebuildWhenPropertyChanged].remove(instanceToRemove);
    }
  }

  void propertyChanged({String propertyName, Key key}) {
    if (_instancesToNotify.containsKey(propertyName)) {
      for (var instanceToNotify in _instancesToNotify[propertyName]) {
        if (instanceToNotify.source.key == key) {
          instanceToNotify.rebuild();
        }
      }
    }
  }
}
