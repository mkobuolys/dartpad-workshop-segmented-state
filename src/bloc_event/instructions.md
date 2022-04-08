# Implementing `ShapeLoadStarted` event

As already mentioned, methods inside the _BLoC_ could be triggered by adding events - let's implement this behaviour.

First of all, a specific _BLoC_ event should be created that will trigger the `ShapeData` loading inside the `ShapeBloc`:

```
class ShapeLoadStarted extends ShapeEvent {}
```

For the `ShapeBloc` to handle the event, the event handler should be registered in the _BLoC's_ constructor

```
ShapeBloc(<...>) {
  on<ShapeLoadStarted>(_onShapeLoadStarted);
}
```

and implemented inside the _BLoC_ (for now, let's only print "_on ShapeLoadStarted_" in the console):

```
Future<void> _onShapeLoadStarted(
  ShapeLoadStarted event,
  Emitter<ShapeState> emit,
) async {
  print('on ShapeLoadStarted');
}
```

## Adding events from UI

To be able to add events to the _BLoC_, the `ShapeBloc` must be provided to the Widget tree. This way, all the child elements in the tree could access the _BLoC_, add events as well as listen to state changes:

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

What's left is finally adding a `ShapeLoadStarted` to the _BLoC_ on the floating action button (FAB) press:

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

If you run the application now, you should notice that "_on ShapeLoadStarted_" is printed in the console once the FAB is pressed. **Congratulations**, you have just connected your UI with `ShapeBloc`!

Next, we will focus on the `ShapeState` class.
