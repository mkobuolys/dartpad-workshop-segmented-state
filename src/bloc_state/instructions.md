# Implement `ShapeState`

If you use the **_Single Flow Pattern_**, the `ShapeBloc` state classes would look like this:

```
@immutable
abstract class ShapeState {
  const ShapeState();
}

class ShapeInitial extends ShapeState {}

class ShapeLoading extends ShapeState {}

class ShapeSuccess extends ShapeState {
  const ShapeState({required this.data});

  final ShapeData data;
}

class ShapeError extends ShapeState {
  const ShapeState({required this.error});

  final ShapeDataException error;
}
```

However, when using the **_Segmented State Pattern_**, only a single class is needed - different flows are implemented as class properties.

_TODO 1-2_ - Add `data`, `error` and `isLoading` properties to the `ShapeState` class and its constructor:

```
@immutable
class ShapeState {
  const ShapeState({
    this.data,
    this.error,
    this.isLoading = false,
  });

  final ShapeData? data;
  final ShapeDataException? error;
  final bool isLoading;

  <...>
}
```

<!-- What happened to Initial? Depending on the experience, initial is important 
and distinct from Loading, Success, or error states. For example, the initial 
state might prompt someone to enter text in a text box. If it an initial state 
isn't necessary for this app, I'd consider removing it from the list of classes 
mentioned above since it feels like an omission here :) -->
As you may notice, the _success_ state is covered by the `data` property, error - by `error` one, and `isLoading` shows whether the data load is in progress or not.

_TODO 3_ - Also, it's practical to add some helper methods to your state, like `copyWith()`. This method is used when you need to clone the current state but only change some properties of it:

```
@immutable
class ShapeState {
  <...>

  ShapeState copyWith({
    ShapeData? data,
    ShapeDataException? error,
    bool? isLoading,
  }) {
    return ShapeState(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  <...>
}
```

_TODO 4-5_ - Then, you need to override the equality operator (`==`) and `hashCode` getter so that state objects are compared by their property values and not the class reference:

```
@immutable
class ShapeState {
  <...>

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShapeState &&
      other.data == data &&
      other.error == error &&
      other.isLoading == isLoading;
  }

  @override
  // Use Object.hash instead?
  int get hashCode => Object.hash(data, error, isLoading);

  <...>
}
```

_TODO 6_ - Lastly, override the `toString()` method that will help you print a more beautiful output of the current state:

```
@immutable
class ShapeState {
  <...>

  @override
  String toString() {
    return 'ShapeState(data: $data, error: $error, isLoading: $isLoading)';
  }
}
```

In real-world projects, it is recommended to use packages like [`equatable`](https://pub.dev/packages/equatable) or [`freezed`](https://pub.dev/packages/freezed) that will cover the required equality comparison overrides for you.

In the next step, you will implement the actual data loading and handle the _Segmented State_ of the `ShapeBloc`.
