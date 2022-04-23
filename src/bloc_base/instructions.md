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

_TODO 3_ - Finally, using the [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) library, create a `ShapeBloc` that uses the defined `ShapeEvent` and `ShapeState` classes. Notice that the `ShapeBloc` stores a reference to `ShapeRepository`, which is used to load shape data:

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

<img alt="Google Analytics" src="https://www.google-analytics.com/collect?v=1&cid=1&t=pageview&ec=workshop&ea=open&dp=%3Fwebserver%3Dhttps%3A%2F%2Fdartpad-ws-segmented-state.web.app%23Step3&dt=create_bloc_classes&tid=UA-226953365-1" style="width: 1px; height: 1px"/>
