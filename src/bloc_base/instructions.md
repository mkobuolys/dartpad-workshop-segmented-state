# Create BLoC classes

Each Business Logic Component (_BLoC_) consists of three parts: _BLoC_, _Events_ and _State_. In this step, you will add them to the app.

When you need to execute a specific operation in the _BLoC_, an event must be sent from the UI. Then, the concrete _BLoC_ handles the event and updates the state.

![BLoC Workflow](https://dartpad-ws-segmented-state.web.app/images/bloc_workflow.png)

_TODO 1_ - To begin with, add a base class for the `ShapeBloc` event - `ShapeEvent`:

```
@immutable
abstract class ShapeEvent {
  const ShapeEvent();
}
```

_TODO 2_ - Then, add a base class for the `ShapeBloc` state class - `ShapeState`:

```
@immutable
class ShapeState {
  const ShapeState();
}
```

_TODO 3_ - Finally, using the _flutter_bloc_ library, create a `ShapeBloc` that uses the defined `ShapeEvent` and `ShapeState` classes. Notice that the `ShapeBloc` stores a reference to `ShapeRepository` that will handle events and load data later:

```
class ShapeBloc extends Bloc<ShapeEvent, ShapeState> {
  ShapeBloc({
    required ShapeRepository shapeRepository,
  })  : _shapeRepository = shapeRepository,
        super(const ShapeState());

  final ShapeRepository _shapeRepository;
}
```

Now, it's time to add a specific `ShapeEvent` that triggers the `ShapeData` load inside the `ShapeBloc`.
