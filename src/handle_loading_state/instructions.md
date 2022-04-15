# Rendering _loading_ state

When the floating action button is tapped, it initiates the data load inside the `ShapeBloc`. However, there is no indication of the loading progress. Also, the button itself remains visible and there is an urgency to tap it multiples times only to trigger a change in the UI. Let's fix this!

## Using the `isLoading` property

To show that the shape data loading is in progress, we could render the `CircularProgressIndicator` instead of the `Shape` widget. For this, we use the `isLoading` property from the current `ShapeBloc` state:

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

Also, it would be nice to hide the floating action button when the data load is in progress. We can achieve this by setting the `floatingActionButton` property inside `Scaffold` to _null_ when the `isLoading` property is _true_:

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

Now you can run the code to see how the loading state is handled in UI once we start the data load. Notice that the floating action button even supports a smooth scale transition out of the box!

Indeed, the `CircularProgressIndicator` renders correctly. However, the shape does not get updated in error cases, and no visual indication is visible in the UI. The last state workflow to handle is the _error_ one.
