import 'package:flutter/material.dart';
import 'package:binding/binding.dart';

import 'app_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BindingProvider(
      child: BindingSource<AppModel>(
        instance: AppModel(),
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Binding<AppModel>(
          source: BindingSource.of<AppModel>(context),
          path: AppModel.itemsPropertyName,
          builder: (_, model) => model.items.length == 0
              ? Text('No items in list')
              : ListView.builder(
                  itemCount: model.items.length,
                  itemBuilder: (_, index) => Text(model.items[index]),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => BindingSource.of<AppModel>(context)
            .addItem(DateTime.now().toString()),
      ),
    );
  }
}
