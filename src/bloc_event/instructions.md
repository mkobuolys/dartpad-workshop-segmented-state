# Implement `ShapeLoadStarted` event

As already mentioned, methods inside the _BLoC_ could be triggered by adding events. Then, each specific event uses the corresponding event handler that executes the logic and changes the state.

For this app, you need to create a dedicated `ShapeBloc` event to load the `ShapeData` and change the `ShapeState` later.

_TODO 1_ - First of all, create a specific _BLoC_ event that will trigger the `ShapeData` loading inside the `ShapeBloc` - `ShapeLoadStarted`:

```
class ShapeLoadStarted extends ShapeEvent {}
```

_TODO 2_ - For the `ShapeBloc` to handle the event, implement a dedicated event handler inside the `ShapeBloc`. For now, only print the _"on ShapeLoadStarted"_ message in the _DartPad_ console:

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  print('on ShapeLoadStarted');
}
```

_TODO 3_ - To map the `ShapeLoadStarted` with the event handler (`_onShapeLoadStarted()`), register it in the constructor of the `ShapeBloc`:

```
ShapeBloc(<...>) {
  on<ShapeLoadStarted>(_onShapeLoadStarted);
}
```

## Add events from UI

_TODO 4_ - To be able to add events to the `ShapeBloc`, it has to be provided to the Widget tree. This way, all the child elements in the tree could access the _BLoC_, add events as well as listen to state changes:

```
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => ShapeBloc(
      shapeRepository: context.read<ShapeRepository>(),
    ),
    child: ShapeView(title: title),
  );
}
```

_TODO 5_ - What's left is finally adding a `ShapeLoadStarted` to the `ShapeBloc` on the floating action button (_FAB_) tap:

```
@override
Widget build(BuildContext context) {
  return Scaffold(
    <...>
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.refresh),
      onPressed: () {
        context.read<ShapeBloc>().add(ShapeLoadStarted());
      },
    ),
  );
}
```

If you run the app now, you should notice that _"on ShapeLoadStarted"_ is printed in the DartPad console once the _FAB_ is tapped.

**Congratulations!** You have connected your UI with `ShapeBloc`!

Next, you will focus on the `ShapeState` class and implement its details.
