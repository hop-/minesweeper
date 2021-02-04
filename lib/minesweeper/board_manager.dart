import 'board.dart';

const int _minWidth = 10;
const int _maxWidth = 90;
const int _minHeight = 10;
const int _maxHeight = 90;
const int _minMineCount = 10;

class BoardManager {
  Board _board;
  int _width;
  int _height;
  int _mineCount;

  get width => this._width;
  get height => this._height;
  get mineCount => this._mineCount;

  BoardManager()
      : _width = _maxWidth,
        _height = _maxHeight,
        _mineCount = _minMineCount;

  setSettings(int w, h, m) {
    this._width = w > _minWidth ? w : _minWidth;
    if (this._width > _maxWidth) {
      this._width = _maxWidth;
    }

    this._height = h > _minHeight ? h : _minHeight;
    if (this._height < _maxHeight) {
      this._height = _maxHeight;
    }

    this._mineCount = m > _minMineCount ? m : _minMineCount;
    if (this._mineCount > this._width * this._height * 0.8) {
      this._mineCount = (this._width * this._height * 0.8).round();
    }

    this._board = null;
  }

  start() {
    _board = Board(this._width, this._height, this._mineCount);
  }

  bool checkCell(int x, int y) {
    return this._board.checkCell(x, y);
  }

  bool markUnmarkCell(int x, int y) {
    return this._board.markUnmarkCell(x, y);
  }

  // TODO add methods
}
