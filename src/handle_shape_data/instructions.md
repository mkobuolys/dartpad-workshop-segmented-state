# Render _success_ state (shape data)

Finally, it's time to get to the visual part of this workshop! 💙

First stop - observing and handling the `data` property, or the _success_ state.

## Use `data` property

_TODO 1_ - To begin with, add `BlocBuilder` to the `ShapeView` widget to rebuild the UI in response to the `ShapeState` change:

```
class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapeBloc, ShapeState>(
      builder: (context, state) {
        return Scaffold(<...>);
      },
    );
  }
}
```

_TODO 2_ - Then, render the generated shape. For this, use the `data` property from the current `ShapeBloc` state and pass it to the `Shape` widget:

```
@override
Widget build(BuildContext context) {
  return BlocBuilder<ShapeBloc, ShapeState>(
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Shape(shapeData: state.data),
        ),
        <...>
      );
    },
  );
}
```

Run the code to see how the _success_ state is handled in UI. Notice that the loaded shape pops on the screen without any indication of data loading? Or that nothing happens in case of an error? Thus, you will handle the _loading_ and _error_ states in the next steps!

<img alt="Google Analytics" src="https://www.google-analytics.com/collect?v=1&cid=1&t=pageview&ec=workshop&ea=open&dp=%3Fwebserver%3Dhttps%3A%2F%2Fdartpad-ws-segmented-state.web.app%23Step7&dt=render_success_state&tid=UA-226953365-1" style="width: 1px; height: 1px"/>
