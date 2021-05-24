import 'package:binding/binding.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// Step 1: Create a model for your state.
// Make sure to extend NotifyPropertyChanged

class CounterModel extends NotifyPropertyChanged {
  // Create a constant for each property name (Optional, but recommend)
  static const countPropertyName = 'count';

  // Properties
  // Recommended that they are private with getters so they cannot
  // be modified without going through a method in the model class
  int _count = 0;

  int get count => _count;

  // Methods
  void incrementCount() {
    _count++;
    // Whenever a property is modified in code, make sure to call
    // propertyChanged with the correct property name string/constant
    propertyChanged(propertyName: countPropertyName);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Example',
      // Step 2: Add a BindingProvider to the root of your application
      // Note: There should only be one BindingProvider in the application.
      home: BindingProvider(
        // Optional: Use BindingSource to make an
        // instance of the model available to all child widgets.
        // Alternatively, the model can also be a property of the widget and passed
        // down to its children in the constructor or using any other mechanism.
        child: BindingSource<CounterModel>(
          instance: CounterModel(),
          child: MyHomePage(),
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
        title: Text('Flutter Counter Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // Step 3: Use Binding widget to bind the instance of the model to
            // the widget tree and tell it when the tree should be rebuilt using
            // the path parameter.
            Binding<CounterModel>(
              source: BindingSource.of<CounterModel>(context),
              path: CounterModel.countPropertyName,
              builder: (_, model) => Text(
                '${model.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: BindingSource.of<CounterModel>(context).incrementCount,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
