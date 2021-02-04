import 'package:flutter/material.dart';
import 'package:minesweeper/app/minesweeper.dart';
import 'game_themes.dart';

class App extends StatelessWidget {
  final String _appName = 'Minesweeper';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: gameThemes[2],
      home: Scaffold(
        body: Center(
          child: Minesweeper(),
        ),
        floatingActionButton: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ),
    );
  }
}
