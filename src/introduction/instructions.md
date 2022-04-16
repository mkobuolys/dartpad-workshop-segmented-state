# Introduction

Welcome to **Segmented State Pattern** using the `flutter_bloc` library workshop! 👋

In this workshop, you will learn the principles of a segmented state and how to implement it using the `flutter_bloc` library. Once you know the basics, the pattern could be applied to other state management solutions, too!

To keep better track of the **Segmented State Pattern** in this workshop, it is recommended to be familiar with the core concepts of [bloc](https://bloclibrary.dev/#/coreconcepts?id=bloc) and [flutter_bloc](https://bloclibrary.dev/#/flutterbloccoreconcepts) libraries - skimming through the documentation should be enough.

## What is a Segmented State Pattern?

![Segmented State Pattern](https://dartpad-ws-segmented-state.web.app/images/segmented_state_pattern.png)

When using `flutter_bloc`, a common way to handle the BLoC state is by creating separate classes for each specific state (_initial_, _loading_, _success_, _error_) and switching between them. It is a **Single Flow Pattern** since only a single state could exist at any given moment.

This way of handling states is predictable and isolated (each specific state class contains information only about that state). However, it also brings several challenges:

1. Two states cannot exist at the same time - it is common to have _data_ and _loading_ states together, for example, during data reload.
2. Extra effort is needed to get to the previous state, e.g., in case of an _error_ state, you want to show the previously loaded _data_ state instead.

The main idea behind the **Segmented State Pattern** is to move from the separated/isolated state structure:

```
abstract class State {}

class DataState extends State {}
class LoadingState extends State {}
class ErrorState extends State {}
```

to a segmented one:

```
class State {
  final Data? data;
  final Error? error;
  final bool isLoading;
}
```

This way, you always have three different flows in your state at any given moment. Hence, it becomes easier to transform, combine and later observe them.

In the next step, you will review the initial code of this workshop.
