import 'dart:math';
import 'cell.dart';

final _rand = Random();

final int horizontalHalfClickArea = 1;
final int verticalHalfClickArea = 1;

class Board {
  final List<Cell> _board;
  final int _width, _height, _mineCount;

  get width => this._width;
  get height => this._height;

  Board(this._width, this._height, this._mineCount) : _board = [];

  // TODO add board methods

  bool markCell(int x, int y) {
    final index = y * this._width + x;

    if (this._board[index].status != CellStatus.none) {
      return false;
    }

    this._board[index].status = CellStatus.marked;

    return true;
  }

  bool unmarkCell(int x, int y) {
    final index = y * this._width + x;

    if (this._board[index].status != CellStatus.marked) {
      return false;
    }

    this._board[index].status = CellStatus.none;

    return true;
  }

  bool markUnmarkCell(int x, int y) {
    if (!markCell(x, y)) {
      return unmarkCell(x, y);
    }

    return true;
  }

  bool checkCell(int x, int y) {
    final index = y * this._width + x;

    return _checkCell(this._board[index], x, y);
  }

  bool _checkCell(Cell cell, int x, int y) {
    if (cell.status == CellStatus.none) {
      return true;
    }

    cell.status = CellStatus.checked;

    if (cell.mine) {
      return false;
    }

    if (cell.value == 0) {
      forEachNeighbor(x, y, this._checkCell);
    }

    return true;
  }

  forEachNeighbor(int x, int y, Function(Cell, int, int) f) {
    final int xMax = x + 1 >= this._width ? this._width : x + 1;
    final int xMin = x - 1 <= 0 ? 0 : x - 1;
    final int yMax = y + 1 >= this._height ? this._height : y + 1;
    final int yMin = y - 1 <= 0 ? 0 : y - 1;

    for (int i = yMin; i < yMax; i++) {
      for (int j = xMin; j < xMax; j++) {
        if (i == y && j == x) {
          continue;
        }
        f(this._board[i * this._height + j], i, j);
      }
    }
  }

  _resetBoard() {
    if (_board.isEmpty) {
      return;
    }

    _board.removeRange(0, _board.length - 1);
  }

  initializeRandomBoard({int x, int y}) {
    _resetBoard();

    final cellCount = this._width * this._height;

    var boardTemplate = new List<int>.generate(cellCount, (i) => i);
    final List<int> minedCellIndices = [];

    final int xMax = x + horizontalHalfClickArea >= this._width
        ? this._width
        : x + horizontalHalfClickArea;
    final int xMin = xMax - (2 * horizontalHalfClickArea + 1);
    final int yMax = y + verticalHalfClickArea >= this._height
        ? this._height
        : y + verticalHalfClickArea;
    final int yMin = yMax - (2 * verticalHalfClickArea + 1);
    for (int i = yMin; i < yMax; i++) {
      for (int j = xMin; j < xMax; j++) {
        boardTemplate.removeAt(i * this._height + j);
      }
    }

    for (int i = 0; i < this._mineCount; i++) {
      var randomIndex = _rand.nextInt(cellCount - i);

      minedCellIndices.add(boardTemplate[randomIndex]);
      boardTemplate.removeAt(randomIndex);
    }
    minedCellIndices.sort();

    int currentMineIndex = 0;
    minedCellIndices.forEach((nextMineIndex) {
      for (int i = currentMineIndex; i < nextMineIndex; i++) {
        this._board.add(Cell(false));
      }
      this._board.add(Cell(true));
      currentMineIndex = nextMineIndex + 1;
    });

    this._setCellValues();
  }

  _setCellValues() {
    for (int y = 0; y < this._height; y++) {
      for (int x = 0; x < this._width; x++) {
        final int index = y * this._width + x;
        if (this._board[index].mine) {
          continue;
        }
        this.forEachNeighbor(
            x,
            y,
            (cell, x, y) => {
                  if (!cell.mine) {cell.value++}
                });
      }
    }
  }
}
