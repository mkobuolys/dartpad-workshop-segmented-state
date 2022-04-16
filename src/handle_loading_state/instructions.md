# Render _loading_ state

At the moment, tapping the floating action button initiates the data load inside the `ShapeBloc`. However, there is no indication of the loading progress. Also, the button itself remains visible, and there is an urgency to tap it multiples times only to trigger a change in the UI. It's time to fix this!

## Use `isLoading` property

To show that the shape data loading is in progress, render the `CircularProgressIndicator` instead of the `Shape` widget. For this, use the `isLoading` property from the current `ShapeBloc` state:

```
@override
Widget build(BuildContext context) {
  return BlocBuilder<ShapeBloc, ShapeState>(
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Shape(shapeData: state.data),
        ),
        <...>
      );
    },
  );
}
```

Also, it would be nice to hide the floating action button when the data load is in progress. To achieve this, set the `floatingActionButton` property inside `Scaffold` to `null` when the `isLoading` property is `true`:

```
@override
Widget build(BuildContext context) {
  return BlocBuilder<ShapeBloc, ShapeState>(
    builder: (context, state) {
      return Scaffold(
        <...>
        floatingActionButton: !state.isLoading
            ? FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<ShapeBloc>().add(ShapeLoadStarted());
                },
              )
            : null,
      );
    },
  );
}
```

Run the code and tap on the floating action button to see how the loading state is handled in UI once you initiate the data load. Notice that the _FAB_ even supports a smooth scale transition out of the box!

Indeed, the `CircularProgressIndicator` renders correctly. However, the shape does not get updated in error cases, and no visual indication is visible in the UI. The last state workflow to handle is the _error_ one.
