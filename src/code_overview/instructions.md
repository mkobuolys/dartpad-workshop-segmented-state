# Code overview

Here, you see a simple shape generation app. This app loads shape information (color and dimensions) and renders the shape in the UI.

Throughout this workshop, you will build on this codebase. You will implement the _BLoC_ related classes (events, state and the _BLoC_ itself), provide the _BLoC_ to the widget tree and later handle different state flows in the UI.

Try to run the app now. You should notice that a shape placeholder is rendered in the center of the screen. Also, there is a floating action button that does nothing at the moment, but later it will trigger the shape's data loading.

The UI code at the moment consists of `ShapePage` and `ShapeView` that renders the page with a basic `Scaffold` and its elements: app bar, floating action button, and body:

```
Scaffold(
  appBar: AppBar(title: Text(title)),
  body: const Center(
    child: Shape(),
  ),
  floatingActionButton: FloatingActionButton(
    child: const Icon(Icons.refresh),
    onPressed: () {},
  ),
);
```

`Shape` widget is rendered inside the body. If the `ShapeData` value is available, it renders a rectangular of a specific color, a placeholder otherwise.

## Shape data classes

Following the _Shape data_ section in the file, you could find a custom exception - `ShapeDataException`, shape data source - `ShapeRepository` - and the `ShapeData` model itself.

`ShapeRepository` will be used by the implemented _BLoC_ class. The repository is responsible for generating `ShapeData` properties and simulating an asynchronous data load - success or error:

```
class ShapeRepository {
  const ShapeRepository();

  Future<ShapeData> getShapeData() async {
    final random = math.Random();

    // Simulate asynchronous data loading
    await Future.delayed(const Duration(seconds: 2));

    // Simulate data loading error
    if (random.nextBool()) throw ShapeDataException();

    final color = <...>;
    final height = <...>;
    final width = <...>;

    return ShapeData(color: color, height: height, width: width);
  }
}
```

Next, you will start with shaping (no pun intended) _BLoC_ related classes.
