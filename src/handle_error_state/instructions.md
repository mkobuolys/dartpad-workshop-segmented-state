# Render _error_ state

The last workflow to handle is the _error_ state. In case of a data loading error, it would be nice to show a `SnackBar` with the error message stored in the `ShapeDataException` object. Is it complex to implement? Not at all!

## Use `error` property

Firstly, "upgrade" the `BlocBuilder` widget and replace it with `BlocConsumer`. The main difference between these two widgets is that `BlocConsumer` additionally exposes a listener that could trigger an action on state change. Showing a `SnackBar` is a side action that happens on error. Thus, it makes sense to use a `listener` callback of `BlocConsumer` for that.

Check if the error property is not `null` inside the listener. If there is an error in the state, create a `SnackBar` and show it in the UI for 2 seconds:

```
class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShapeBloc, ShapeState>(
      listener: (context, state) {
        final error = state.error;

        if (error != null) {
          final snackBar = SnackBar(
            content: Text('$error'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: <...>
    );
  }
}
```

At the moment, the `listener` is called on each state change. However, it should not be triggered when the `data` or `isLoading` properties are updated, only when the `error` changes. Optimise this behaviour by defining the `listenWhen` condition:

```
class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShapeBloc, ShapeState>(
      listenWhen: (previous, current) => previous.error != current.error,
      <...>
    );
  }
}
```

Now, the `listener` will be triggered only on the `error` property change.

You can run the app now and see the outcome of this workshop. All different state workflows are handled - after each data load, either the shape is updated, or the error message appears at the bottom of the screen.
