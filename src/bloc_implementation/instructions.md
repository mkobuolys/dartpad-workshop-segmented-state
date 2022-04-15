# Handling the Segmented State

As defined by the _Segmented State Pattern_, we manipulate properties on the state object based on the data flow and results.

Here is the workflow of how the `ShapeState` is handled on each `ShapeLoadStarted` event:

1. Set the `isLoading` flag to `true`;
2. Load data from the `ShapeRepository`;
3. Handle result:
   - In case of success, store the result in the `data` property;
   - In case of an exception, set the `error` property;
4. Set the `isLoading` flag to `false`.

Let's convert this list into code!

## Implementing handler

Firstly, we set that the data is loading at the beginning of operation:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  <...>
}
```

As you may notice, we are using the previously implemented `copyWith` method that takes the current state, copies it and only replaces the `isLoading` property.

Then, add the `try/catch` block that will handle two data flows - success and error. First of all, we load the data from the repository and set the result on success:

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

If the `_shapeRepository.getShapeData()` operation throws a `ShapeDataException`, we must handle it inside the `catch` block and set the error in our state:

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

Finally, we set the loading progress property to _false_ - the operation is finished.

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

We were reusing the same state and updated individual properties - the state changes will be observed later on by the UI and used to render the specific components or execute additional logic.

In the next step, we will handle the loading state in our UI!
