import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

// ignore: public_member_api_docs
class Main extends StatelessWidget {
  // ignore: public_member_api_docs
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

/// State
class MyAppState extends ChangeNotifier {
  /// Greeting to be displayed
  String greeting = "Hello there";

  Random _random = Random();

  /// Theme to be used throughout the app
  ColorScheme themeData = ColorScheme.fromSeed(seedColor: Colors.deepOrange);

  /// Counter of taps
  int numberOfTaps = 0;

  /// Change theme
  void getNext() {
    final index = _random.nextInt(10);
    themeData = ColorScheme.fromSeed(seedColor: Colors.primaries[index]);

    numberOfTaps++;

    notifyListeners();
  }
}

// ignore: public_member_api_docs
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final theme = appState.themeData;
    final greeting = appState.greeting;

    const double kPaddingHeight = 10;

    return GestureDetector(
      onTap: () {
        appState.getNext();
      },
      child: Scaffold(
        backgroundColor: theme.secondary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigCard(greeting: greeting),
              SizedBox(height: kPaddingHeight),
              TapsCounter(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that shows number of taps
class TapsCounter extends StatelessWidget {
  // ignore: public_member_api_docs
  const TapsCounter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: appState.themeData.onPrimary,
    );

    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: appState.numberOfTaps != 0,
      child: Text(appState.numberOfTaps.toString(), style: style),
    );
  }
}

/// Widget to display greeting
class BigCard extends StatelessWidget {
  /// Greetings value
  final String greeting;

  // ignore: public_member_api_docs
  const BigCard({
    super.key,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();

    final colorScheme = appState.themeData;

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: colorScheme.onPrimary,
    );

    return Card(
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(greeting, style: style),
      ),
    );
  }
}
