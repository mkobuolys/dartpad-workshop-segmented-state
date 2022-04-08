# Rendering _success_ state (shape data)

Finally, it's time to get to the visual part of this workshop 🎉

First stop - observing and handling the `data` property, or the _success_ state.

## Using the `data` property

To begin with, we should add `BlocBuilder` to the `ShapeView` widget to handle widget building in response to new states:

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

Then, we can render the generated shape. For this, we use the `data` property from the current `ShapeBloc` state:

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

Now you can run the code to see how the success state is handled in UI. However, the loaded shape just pops on the screen without any indication of data loading. Thus, let's handle the _loading_ state next!
