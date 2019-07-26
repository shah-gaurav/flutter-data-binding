# Data Binding

A state management package for Flutter that supports data bindings. This package is inspired by .NET INotifyPropertyChanged interface and should feel familiar to .NET developers that have worked with .NET applications in WPF/Xamarin. 

# Introduction

Recently I read a Flutter State Management article on Medium: [Flutter #OneYearChallenge; Scoped Model vs BloC Pattern vs States Rebuilder](https://medium.com/flutter-community/flutter-oneyearchallenge-scoped-model-vs-bloc-pattern-vs-states-rebuilder-23ba11813a4f)

This article discussed various different state management techniques and consisted of a challenge that the author of the article solved using the [States_rebuilder](https://pub.dev/packages/states_rebuilder) state management package that the author has developed.

The current recommended Flutter state management solution from the Flutter team is the [Provider package](https://pub.dev/packages/provider). So I attempted to solve the challenge presented in the article using the Provider package. My attempt and subsequent failure to solve the challenge using the provider package is at [https://github.com/shah-gaurav/flutter-app-one-year-challenge](https://github.com/shah-gaurav/flutter-app-one-year-challenge)

However, this peaked my curiosity to learn more about state management in Flutter. So I decided that instead of using a package for state management, I should create state management solution from the ground up to solve the challenge. Since my background is in .NET and c# development, the solution I came up with tries to leverage concepts from my experience in those technologies.
 
 This package is the resulting state management framework I created to solve the challenge. The solution to the challenge is located in the example folder.

# Get Started

To use the data bindings package is an easy three step process:

Step 1 - Create a data model that inherits from `NotifyPropertyChanged` and calls `propertyChanged` whenever a property of the model is changed.

```dart
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
```

Step 2 - Add a `BindingProvider` widget to the root of the application. 

```dart
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
```

Step 3 - Use the `Binding` widget to attach an instance of the model to the tree and tell it when the instance should be rebuilt.

```dart
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
                style: Theme.of(context).textTheme.display1,
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
```
Now every time the `incrementCount` method is called on the instance of the `CounterModel`, a `propertyChanged` event will be raised. This event will bubble up to the global `BindingProvider` and back down to all the `Binding` widgets that are registered to receive that specific event causing them to rebuild.