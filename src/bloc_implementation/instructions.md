# Handle the _Segmented State_

As defined by the _Segmented State Pattern_, you do not create individual objects for each state but rather manipulate properties on the state object based on the data flow and results.

Here is the workflow of how the `ShapeBloc` should handle the `ShapeLoadStarted` event and how the `ShapeState` changes:

1. Set the `isLoading` flag to `true`;
2. Load data from the `ShapeRepository`;
3. Handle result:
   - In case of success, store the result in the `data` property;
   - In case of an exception, set the `error` property;
4. Set the `isLoading` flag to `false`.

Now it's time to convert this list into code!

## Implement the event handler

To begin with, set that the data is loading at the beginning of the operation. Use the previously implemented `copyWith()` method that takes the current state, copies it and only replaces the `isLoading` property:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  <...>
}
```

Then, add the `try/catch` block that handles two data flows - success and error. First of all, load the shape data from the repository and set the result on success:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  <...>

  try {
    final shape = await _shapeRepository.getShapeData();

    emit(state.copyWith(data: shape));
  } on ShapeDataException catch (e) {
    <...>
  } finally {
    <...>
  }
}
```

If the `_shapeRepository.getShapeData()` operation throws a `ShapeDataException`, it must be handled inside the `catch` block by setting the `error` in the state:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  <...>

  try {
    <...>
  } on ShapeDataException catch (e) {
    emit(state.copyWith(error: e));
  } finally {
    <...>
  }
}
```

Finally, set the loading progress property to `false`, which indicates the end of data loading:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  <...>

  try {
    <...>
  } finally {
    emit(state.copyWith(isLoading: false));
  }
}
```

You were reusing the same state and updated individual properties - the state changes will be observed later on by the UI and used to render the specific components or execute additional logic.

Next, you will handle the `ShapeState` in the UI layer, starting with the loading state!
