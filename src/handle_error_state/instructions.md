# Rendering _error_ state

The last workflow to handle is the _error_ state. In case of a data loading error, it would be nice to show a `SnackBar` with the error message that is stored in the `ShapeDataException` object. Is it hard to implement? Not at all!

## Using the `error` property

Firstly, we should "upgrade" the `BlocBuilder` widget and replace it with `BlocConsumer`. The main difference between these two widgets is that `BlocConsumer` additionally exposes a listener that could trigger an action on state change. Showing a `SnackBar` is a side action that should happen on error, thus it makes sense to use listener for that:

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

Inside the listener, we check if the error property is not _null_. If there is an error in the state, we create a `SnackBar` and show it in the UI for 2 seconds.

At the moment, the `listener` will be called on each state change. However, we are not interested in whether the `data` or `isLoading` are updated, we should only listen to the `error` changes. We can optimise this behaviour by implementing `listenWhen`:

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

Now, the listener will be triggered only on the `error` property change.

You can run the application now and see the outcome of this workshop. All different state workflows are handled - after each data load, either the shape is updated, or the error message appears at the bottom of the screen.
