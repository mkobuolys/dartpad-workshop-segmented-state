# Code overview

Here, you see a simple shape generation app. This app loads shape information (color and dimensions) and renders the shape in the UI.

Throughout this workshop, you will build on this codebase. You will implement the _BLoC_ related classes (events, state and the _BLoC_ itself), provide the _BLoC_ to the widget tree and later handle different state flows in the UI.

Try to run the app now. You should notice that a shape placeholder is rendered in the center of the screen. Also, there is a floating action button that does nothing at the moment, but later it will trigger the shape's data loading.

<!-- Why are ShapeView and ShapePage separate? ShapePage just calls to 
ShapeView? Even in later steps, it looks like all it does is wrap the ShapeView
with a BlocProvider? Couldn't the `ShapePage` define the layout code (Scaffold) for 
the page? Or remove the ShapePage entirely? --> 
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

<!-- Maybe talk about what repositories do in general? -->
`ShapeRepository` will be used by the implemented _BLoC_ class. The repository is responsible for generating `ShapeData` properties and simulating an asynchronous data load - success or error:

```
class ShapeRepository {
  const ShapeRepository();

  Future<ShapeData> getShapeData() async {
    <...>
  }
}
```

_TODO 1_ - First of all, create an instance of `math.Random()` to generate `boolean` and `int` values:

```
Future<ShapeData> getShapeData() async {
  final random = math.Random();

  // Simulate asynchronous data loading
  await Future.delayed(const Duration(seconds: 1));

  <...>
}
```

_TODO 2_ - To simulate a data loading error, generate a `boolean` value. If the result is `true`, throw a `ShapeDataException`:

```
Future<ShapeData> getShapeData() async {
  <...>

  // Simulate data loading error
  if (random.nextBool()) throw ShapeDataException();

  <...>
}
```

_TODO 3-4_ - Generate `color`, `height` and `width` values - `color` is a random RGB value while `height` and `width` are integer values between _150.0_ and _250.0_. Use them to create a `ShapeData` result:

```
Future<ShapeData> getShapeData() async {
  <...>

  final color = Color.fromRGBO(
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
    1.0,
  );
  final height = 150.0 + random.nextInt(100);
  final width = 150.0 + random.nextInt(100);

  return ShapeData(color: color, height: height, width: width);
}
```

The data layer of this workshop is ready to use. Next, you will start shaping (no pun intended) _BLoC_ related classes.
