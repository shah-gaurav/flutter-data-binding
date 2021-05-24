import 'package:flutter/widgets.dart';

import 'binding_base.dart';
import 'binding_provider.dart';
import 'notify_property_changed.dart';

class Binding<T extends NotifyPropertyChanged> extends StatefulWidget {
  final T source;
  final Widget Function(BuildContext, T) builder;
  final String path;

  Binding({
    required this.source,
    required this.builder,
    required this.path,
  }) : super(key: source.key);

  @override
  _BindingState createState() => _BindingState<T>(
        source: source,
        builder: builder,
        path: path,
      );
}

class _BindingState<T extends NotifyPropertyChanged> extends State<Binding>
    implements BindingBase<T> {
  final Widget Function(BuildContext, T) builder;
  final String path;
  late BindingProvider bindingProvider;

  @override
  T source;

  _BindingState({
    required this.source,
    required this.builder,
    required this.path,
  });

  @override
  void initState() {
    super.initState();
    bindingProvider = BindingProvider.of(context);    
    bindingProvider.add(path, this);
  }

  @override
  void dispose() {
    bindingProvider.remove(path, this);
    super.dispose();
  }

  @override
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, source);
  }
}
