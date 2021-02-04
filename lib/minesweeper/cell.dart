class Cell {
  final bool _isMine;
  int _value;
  CellStatus _status;

  get mine => this._isMine;

  get value => this.status == CellStatus.checked ? this._value : -1;

  set value(newValue) {
    if (newValue < 0 || newValue > 8) {
      return;
    }
    this._value = newValue;
  }

  CellStatus get status => this._status;

  set status(newStatus) => this._status = newStatus;

  Cell(this._isMine) {
    this._value = 0;
    this._status = CellStatus.none;
  }
}

enum CellStatus {
  none,
  checked,
  marked,
}
