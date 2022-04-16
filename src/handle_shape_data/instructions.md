# Render _success_ state (shape data)

Finally, it's time to get to the visual part of this workshop 🎉

First stop - observing and handling the `data` property, or the _success_ state.

## Use `data` property

To begin with, add `BlocBuilder` to the `ShapeView` widget to rebuild the UI in response to the `ShapeState` change:

```
class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapeBloc, ShapeState>(
      builder: (context, state) {
        return Scaffold(<...>);
      },
    );
  }
}
```

Then, render the generated shape. For this, use the `data` property from the current `ShapeBloc` state and pass it to the `Shape` widget:

```
@override
Widget build(BuildContext context) {
  return BlocBuilder<ShapeBloc, ShapeState>(
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Shape(shapeData: state.data),
        ),
        <...>
      );
    },
  );
}
```

Run the code to see how the _success_ state is handled in UI. Notice that the loaded shape pops on the screen without any indication of data loading. Thus, you will handle the _loading_ state next!
