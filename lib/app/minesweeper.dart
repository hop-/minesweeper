import 'package:flutter/material.dart';
import 'minesweeper_painter.dart';

class Minesweeper extends StatefulWidget {
  Minesweeper({Key key}) : super(key: key);

  @override
  _MinesweeperState createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.widthConstraints().maxWidth,
        height: constraints.heightConstraints().maxHeight,
        color: Theme.of(context).backgroundColor,
        child: CustomPaint(
          painter: MinesweeperPainter(),
        ),
      );
    });
  }
}
