import 'package:flutter/material.dart';
import 'package:binding/binding.dart';

import 'model/main_model.dart';
import 'widgets/item_detail_view.dart';
import 'widgets/item_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BindingProvider(
      child: Scaffold(
        body: SafeArea(
          child: BindingSource<MainModel>(
            instance: MainModel(),
            initialize: (mainModel) => mainModel.getItems(),
            child: Column(
              children: <Widget>[
                ItemListView(),
                Divider(),
                ItemDetailView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
