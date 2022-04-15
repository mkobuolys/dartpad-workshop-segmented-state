# Creating BLoC classes

Each _BLoC_ (Business Logic Component) consists of three parts: `BLoC`, `Events` and `State`. Let's start by defining them in our app.

When we want to execute a specific operation in the _BLoC_, from the UI we send the event to the _BLoC_. Then, the specific _BLoC_ handles the event and updates the state.

![BLoC Workflow](https://dartpad-ws-segmented-state.web.app/images/bloc.png)

Let's start by adding a base class for the `ShapeBloc` event:

```
@immutable
abstract class ShapeEvent {
  const ShapeEvent();
}
```

Then, add a base class for the `ShapeBloc` state class:

```
@immutable
class ShapeState {
  const ShapeState();
}
```

Finally, let's create a `ShapeBloc` itself that uses the defined `ShapeEvent` and `ShapeState`. Also, _BLoC_ stores a reference to `ShapeRepository` that will be used later when handling events and loading data.

```
class ShapeBloc extends Bloc<ShapeEvent, ShapeState> {
  ShapeBloc({
    required ShapeRepository shapeRepository,
  })  : _shapeRepository = shapeRepository,
        super(const ShapeState());

  final ShapeRepository _shapeRepository;
}
```

Now we are ready to add a specific `ShapeEvent` to trigger a `ShapeData` load.
