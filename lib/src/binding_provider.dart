import 'package:flutter/widgets.dart';

import 'binding_base.dart';

class BindingProvider extends InheritedWidget {
  final _instancesToNotify = Map<String, List<BindingBase>>();

  BindingProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static BindingProvider of(BuildContext context) {
    var inheritedWidget = context
        .getElementForInheritedWidgetOfExactType<BindingProvider>()
        ?.widget;
    if (inheritedWidget == null) {
      throw new Exception(
          'BindingProvider has not been defined in the widget tree.');
    }
    final provider = inheritedWidget as BindingProvider;
    return provider;
  }

  void add(String rebuildWhenPropertyChanged, BindingBase instanceToAdd) {
    List<BindingBase> list =
        _instancesToNotify[rebuildWhenPropertyChanged] ?? [];
    if (!list.contains(instanceToAdd)) {
      instanceToAdd.source.callback = propertyChanged;
      list.add(instanceToAdd);
    }
    _instancesToNotify[rebuildWhenPropertyChanged] = list;
  }

  void remove(String rebuildWhenPropertyChanged, BindingBase instanceToRemove) {
    List<BindingBase> list =
        _instancesToNotify[rebuildWhenPropertyChanged] ?? [];
    if (list.contains(instanceToRemove)) {
      list.remove(instanceToRemove);
    }
    _instancesToNotify[rebuildWhenPropertyChanged] = list;
  }

  void propertyChanged({required String propertyName, Key? key}) {
    final instancesToNotify = _instancesToNotify[propertyName];
    if (instancesToNotify == null) {
      return;
    }
    for (var instanceToNotify in instancesToNotify) {
      if (instanceToNotify.source.key == key) {
        instanceToNotify.rebuild();
      }
    }
  }
}
