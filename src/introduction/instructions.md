# Introduction

Welcome to **Segmented State Pattern** using the [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) library workshop! 👋

In this workshop, you will learn the principles of a segmented state and how to implement it using the [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) library. Once you know the basics, the pattern could be applied to other state management solutions, too!

This workshop is authored by Mangirdas Kazlauskas 🇱🇹💙

- Twitter: [@mkobuolys](https://twitter.com/mkobuolys)
- GitHub: [@mkobuolys](https://github.com/mkobuolys)

Feel free to reach out if you have any problems or questions during the workshop!

## What is _BLoC_, [`bloc`](https://pub.dev/packages/bloc) and [`flutter_bloc`](https://pub.dev/packages/flutter_bloc)?

![BLoC](https://dartpad-ws-segmented-state.web.app/images/bloc.png)

_Business Logic Component_ (_BLoC_) is a design pattern that helps you separate the business logic from the presentation layer (Flutter widgets) and reuse the code more efficiently. The main idea of this pattern is to send events from your presentation layer to a _BLoC_ object, which processes the events and emits new states through a `Stream`. The presentation layer listens to the `Stream` and rebuilds the UI when a new state is emitted. For more information about this pattern, see [Reactive Programming - Streams - BLoC](https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/).

[`bloc`](https://pub.dev/packages/bloc) is a Dart package that implements the _BLoC_ design pattern and abstracts the underlying low-level logic of _Streams_, implements the base building blocks (classes) of the _BLoC_ state management solution, like `Cubit` or `Bloc`.

[`flutter_bloc`](https://pub.dev/packages/flutter_bloc) exposes the base classes from the [`bloc`](https://pub.dev/packages/bloc) package and implements the specific Flutter widgets. These widgets are used to provide the concrete _BLoC_ objects to the widget tree and later subscribe to their state changes to render UI or trigger asynchronous events.

To learn more about [`bloc`](https://pub.dev/packages/bloc) and [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) packages, see the [official documentation](https://bloclibrary.dev).

_Note:_ In this workshop, the _BLoC_ term is used to refer to specific implementations of _BLoC_ classes that are implemented using [`flutter_bloc`](https://pub.dev/packages/flutter_bloc).

## What is a _Segmented State Pattern_?

![Segmented State Pattern](https://dartpad-ws-segmented-state.web.app/images/segmented_state_pattern.png)

When using [`flutter_bloc`](https://pub.dev/packages/flutter_bloc), a common way to handle the _BLoC_ state is by creating separate classes for each specific state (_initial_, _loading_, _success_, _error_) and switching between them. It is a _Single Flow Pattern_ since only a single state could exist at any given moment.

This way of handling states is predictable and isolated (each specific state class contains information only about that state). However, it also brings several challenges:

1. Two states cannot exist at the same time - it is common to have _data_ and _loading_ states together, for example, during data reload.
2. Extra effort is needed to get to the previous state, e.g., in case of an _error_ state, you want to show the previously loaded _data_ state instead.

The main idea behind the _Segmented State Pattern_ is to move from the separated/isolated state structure:

<!-- Naming is hard. But: aren't these classes "segmented" from one another already? Why is the class that combines all of these states into one object the "segmented state?" Wouldn't that be the "combined" or "aggregate" state? Based on the name alone, I actually kind of thought this workshop was going to go the other way around, haha -- from a single aggregate object to separate classes. -->

```dart
abstract class State {}

class DataState extends State {}
class LoadingState extends State {}
class ErrorState extends State {}
```

to a segmented one:

<!-- Should this follow the bloc conventions of using enums for isLoading or isError kind of states? https://bloclibrary.dev/#/blocnamingconventions?id=single-class-1 -->
```dart
class State {
  final Data? data;
  final Error? error;
  final bool isLoading;
}
```

This way, you always have three different flows in your state at any given moment. Hence, it becomes easier to transform, combine and later observe them.

In the next step, you will review the initial code of this workshop.
