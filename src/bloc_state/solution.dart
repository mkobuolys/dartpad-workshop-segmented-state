// ignore_for_file: unused_field

import 'dart:math' as math show Random;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      const SegmentedStateApp(
        shapeRepository: ShapeRepository(),
      ),
    ),
    blocObserver: SegmentedStateBlocObserver(),
  );
}

class SegmentedStateApp extends StatelessWidget {
  const SegmentedStateApp({
    required this.shapeRepository,
  });

  final ShapeRepository shapeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: shapeRepository,
      child: MaterialApp(
        title: 'Segmented State Pattern',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ShapePage(
          title: 'Segmented State Pattern using flutter_bloc',
        ),
      ),
    );
  }
}

class ShapePage extends StatelessWidget {
  const ShapePage({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShapeBloc(
        shapeRepository: context.read<ShapeRepository>(),
      ),
      child: ShapeView(title: title),
    );
  }
}

class ShapeView extends StatelessWidget {
  const ShapeView({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Shape(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          context.read<ShapeBloc>().add(ShapeLoadStarted());
        },
      ),
    );
  }
}

class Shape extends StatelessWidget {
  const Shape({
    this.shapeData,
  });

  final ShapeData? shapeData;

  @override
  Widget build(BuildContext context) {
    return shapeData == null
        ? const SizedBox(
            height: 250.0,
            width: 250.0,
            child: Placeholder(),
          )
        : Container(
            color: shapeData!.color,
            height: shapeData!.height,
            width: shapeData!.width,
          );
  }
}

// --------------------------------------------
// Below this line are BLoC and data classes

class ShapeBloc extends Bloc<ShapeEvent, ShapeState> {
  ShapeBloc({
    required ShapeRepository shapeRepository,
  })  : _shapeRepository = shapeRepository,
        super(const ShapeState()) {
    on<ShapeLoadStarted>(_onShapeLoadStarted);
  }

  final ShapeRepository _shapeRepository;

  Future<void> _onShapeLoadStarted(
    ShapeLoadStarted event,
    Emitter<ShapeState> emit,
  ) async {
    print('on ShapeLoadStarted');
  }
}

// --------------------------------------------
// BLoC events

@immutable
abstract class ShapeEvent {
  const ShapeEvent();
}

class ShapeLoadStarted extends ShapeEvent {}

// --------------------------------------------
// BLoC state

@immutable
class ShapeState {
  const ShapeState({
    this.data,
    this.error,
    this.isLoading = false,
  });

  final ShapeData? data;
  final ShapeDataException? error;
  final bool isLoading;

  ShapeState copyWith({
    ShapeData? data,
    ShapeDataException? error,
    bool? isLoading,
  }) {
    return ShapeState(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShapeState &&
        other.data == data &&
        other.error == error &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'ShapeState(data: $data, error: $error, isLoading: $isLoading)';
  }
}

// --------------------------------------------
// BLoC observer

class SegmentedStateBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('BLoC created');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('BLoC state changed: $change');
  }
}

// --------------------------------------------
// Shape data

class ShapeDataException implements Exception {
  @override
  String toString() => 'Error while loading shape data.';
}

class ShapeRepository {
  const ShapeRepository();

  Future<ShapeData> getShapeData() async {
    final random = math.Random();

    // Simulate asynchronous data loading
    await Future.delayed(const Duration(seconds: 1));

    // Simulate data loading error
    if (random.nextBool()) throw ShapeDataException();

    final color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1.0,
    );
    final height = 150.0 + random.nextInt(100);
    final width = 150.0 + random.nextInt(100);

    return ShapeData(color: color, height: height, width: width);
  }
}

@immutable
class ShapeData {
  const ShapeData({
    required this.color,
    required this.height,
    required this.width,
  });

  final Color color;
  final double height;
  final double width;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShapeData &&
        other.color == color &&
        other.height == height &&
        other.width == width;
  }

  @override
  int get hashCode => color.hashCode ^ height.hashCode ^ width.hashCode;

  @override
  String toString() {
    return 'ShapeData(color: $color, height: $height, width: $width)';
  }
}
