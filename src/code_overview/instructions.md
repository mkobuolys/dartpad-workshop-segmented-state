# Code overview

Here, we have a simple shape generation app. Its main purpose is to load shape information (color and dimensions) and render it in the UI.

Throughout this workshop, we will build on this code. We will implement the BLoC related classes (events, state and the BLoC itself), provide the BLoC to the widget tree and later handle different state flows.

Try to run the app. You will notice that a shape placeholder is rendered in the center of the screen. Also, there is a floating action button that does nothing at the moment, but later it will trigger the shape's data loading.

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

Inside the body, we render a `Shape` widget. If the `ShapeData` is provided to the widget, a rectangular of a specific color is rendered, a placeholder otherwise.

## Shape data classes

Following the _Shape data_ section in the file, you could find a custom exception `ShapeDataException`, shape data source `ShapeRepository` and the `ShapeData` model itself.

`ShapeRepository` will be used by the BLoC. This class is responsible for generating `ShapeData` properties as well as simulating an asynchronous data load - success or error.

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

In the next step, you will start with shaping (no pun intended) your BLoC classes.
