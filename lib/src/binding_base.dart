import 'notify_property_changed.dart';

abstract class BindingBase<T extends NotifyPropertyChanged> {
  late T source;
  void rebuild();
}
