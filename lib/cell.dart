import 'package:Cyberpwned/path.dart';
import 'package:Cyberpwned/score.dart';
import 'package:Cyberpwned/util.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CellGroup implements Iterable<Iterable<String>> {
  Map<String, bool> state;

  CellGroup(this._group, this.state);

  List<List<String>> _group = [];

  void clear() {
    _group.clear();
  }

  Map<int, List<String>> asMap() {
    return _group.asMap();
  }

  List<T> map<T>(T Function(List<String>) f) {
    return _group.map(f).toList();
  }

  bool any(bool Function(List<String>) f) {
    return _group.any(f);
  }

  bool remove(List<String> elm) {
    return _group.remove(elm);
  }

  List<String> removeAt(int idx) {
    return _group.removeAt(idx);
  }

  void add(List<String> elm) {
    _group.add(elm);
  }

  void insert(int idx, List<String> elm) {
    _group.insert(idx, elm);
  }

  void addAll(Iterable<List<String>> it) {
    _group.addAll(it);
  }

  bool get isNotEmpty { return _group.isNotEmpty; }
  bool get isEmpty { return _group.isEmpty; }
  int get length { return _group.length; }


  @override
  String toString() {
    return _group.toString();
  }

  String get(int r, int c) {
    return _group[r][c];
  }

  List<String> getRow(int r) {
    return _group[r];
  }

  void set(int r, int c, String v) {
    _group[r][c] = v;
  }

  @override
  Iterable<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  bool contains(Object element) {
    return _group.contains(element);
  }

  @override
  Iterable<String> elementAt(int index) {
    return _group.elementAt(index);
  }

  @override
  bool every(bool Function(Iterable<String> element) test) {
    return _group.every(test);
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Iterable<String> element) f) {
    return _group.expand(f);
  }

  @override
  Iterable<String> get first => _group.first;

  @override
  Iterable<String> firstWhere(bool Function(Iterable<String> element) test, {Iterable<String> Function() orElse}) {
    return _group.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Iterable<String> element) combine) {
    return _group.fold(initialValue, combine);
  }

  @override
  Iterable<Iterable<String>> followedBy(Iterable<Iterable<String>> other) {
    return _group.followedBy(other);
  }

  @override
  void forEach(void Function(Iterable<String> element) f) {
    _group.forEach(f);
  }

  @override
  // TODO: implement iterator
  Iterator<Iterable<String>> get iterator => _group.iterator;

  @override
  String join([String separator = ""]) {
    return _group.join(separator);
  }

  @override
  // TODO: implement last
  Iterable<String> get last => _group.last;

  @override
  Iterable<String> lastWhere(bool Function(Iterable<String> element) test, {Iterable<String> Function() orElse}) {
    return _group.lastWhere(test, orElse: orElse);
  }

  @override
  Iterable<String> reduce(Iterable<String> Function(Iterable<String> value, Iterable<String> element) combine) {
    return _group.reduce((value, element) => combine(value, element));
  }

  @override
  // TODO: implement single
  Iterable<String> get single => _group.single;

  @override
  Iterable<String> singleWhere(bool Function(Iterable<String> element) test, {Iterable<String> Function() orElse}) {
    return _group.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<Iterable<String>> skip(int count) {
    return _group.skip(count);
  }

  @override
  Iterable<Iterable<String>> skipWhile(bool Function(Iterable<String> value) test) {
    return _group.skipWhile(test);
  }

  @override
  Iterable<Iterable<String>> take(int count) {
    return _group.take(count);
  }

  @override
  Iterable<Iterable<String>> takeWhile(bool Function(Iterable<String> value) test) {
    return _group.takeWhile(test);
  }

  @override
  List<Iterable<String>> toList({bool growable = true}) {
    return _group.toList(growable: growable);
  }

  @override
  Set<Iterable<String>> toSet() {
    return _group.toSet();
  }

  @override
  Iterable<Iterable<String>> where(bool Function(Iterable<String> element) test) {
    return _group.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return _group.whereType();
  }
}

enum CellType { MATRIX, SEQUENCE, TOGGLE }

class DisplayCell {
  int x;
  int y;
  int bufferSize;
  TraversedPath solution;
  bool showIndex = false;
  List<String> sequences;
  CellGroup matrix;
  CellType _cellType;
  bool solutionFound;

  DisplayCell.forMatrix(this.x, this.y, this.bufferSize, this.sequences, this.solution, this.matrix, {this.showIndex = true}) {
    this._cellType = CellType.MATRIX;
  }

  DisplayCell.forSequence(this.x, this.y, this.bufferSize, this.sequences, this.solution, this.matrix, this.solutionFound, {this.showIndex = false}) {
    this._cellType = CellType.SEQUENCE;
  }

  DisplayCell.forToggle(this.x, this.y, this.bufferSize, this.sequences, this.solution, this.matrix, {this.showIndex = false}) {
    this._cellType = CellType.TOGGLE;
  }

  String _isPartOfSolution() {
    if (bufferSize == null) return null;
    if (solution.coords.length > bufferSize) return null;
    for (int i = 0; i < solution.coords.length; i++) {
      if (solution.coords[i][0] == x && solution.coords[i][1] == y) {
        return (i + 1).toString();
      }
    }
    return null;
  }

  Color _colorForCell() {
    if (bufferSize == null) return AppColor.getDeactivated();
    if (_cellType == CellType.SEQUENCE) {
      if (!(matrix.state[sequences.where((e) => e != "").toList().toString()] == null || matrix.state[sequences.where((e) => e != "").toList().toString()])) {
        return AppColor.getDeactivated();
      }
    }
    if (solution.coords.isEmpty) return AppColor.getInteractable();
    if (solution.coords.length > bufferSize || !solutionFound) return AppColor.getInteractable();

    if (_cellType == CellType.SEQUENCE) {
      if (SequenceScore(sequences.where((element) => element.isNotEmpty && element != "-"), bufferSize).isCompletedBy(solution, matrix)) {
        return AppColor.getSuccess();
      }
      return AppColor.getFailure();
    } else if (_cellType != CellType.SEQUENCE) {
      return (_isPartOfSolution() != null) ? AppColor.getSuccess() : AppColor.getFailure();
    }
    return AppColor.getInteractable();
  }
  List<String> _items = ['1C', '55', 'FF', '7A', 'BD', 'E9', '-'];

  Widget render({String elm, Color color, onTap, void Function() callback}) {
    if (matrix == null) {
      return InkWell(
          onTap: onTap,
          child: AnimatedContainer(
              decoration: BoxDecoration(color: color?.withOpacity(0.3) ?? _colorForCell().withOpacity(0.3),
                  border: _cellType == CellType.MATRIX
                      ? Border.all(color: color ?? _colorForCell(), width: 2)
                      : Border.symmetric(horizontal: BorderSide(color: color ?? _colorForCell(), width: 2))),
              duration: Duration(milliseconds: 300),
              child: Text(
                  elm ?? (showIndex ? (_isPartOfSolution() ?? matrix.get(x, y)) : (_cellType == CellType.MATRIX ? matrix.get(x, y) : sequences[y])),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: color ?? _colorForCell(),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts
                          .rajdhani()
                          .fontFamily))));
    }
    TextStyle style = TextStyle(
        color: _colorForCell(),
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.rajdhani().fontFamily);
    var value = y >= sequences.length ? "" : sequences[y];
    value = value == "" ? "-" : value;
    return InkWell(
        onTap: onTap,
        child: AnimatedContainer(
            decoration: BoxDecoration(color: color?.withOpacity(0.3) ?? _colorForCell().withOpacity(0.3), border: _cellType == CellType.MATRIX ? Border.all(color: color ?? _colorForCell(), width: 2) : Border.symmetric(horizontal: BorderSide(color: color ?? _colorForCell(), width: 2))),
            duration: Duration(milliseconds: 300),
            child: DropdownButtonHideUnderline(child: DropdownButton(
                value: value,
                style: style,
                isExpanded: true,
                iconSize: 0,
                onChanged: (String newValue) {
                  if (_items.contains(newValue)) {
                    if (y >= sequences.length) {
                      this.sequences.add(newValue);
                    } else {
                      this.sequences[y] = newValue;
                    }
                  }
                  if (callback != null) callback();
                },
                items: _items.map((String each) {
                  return DropdownMenuItem<String>(
                    value: each,
                    child: Container(alignment: Alignment.center, child: Text(each, style: style, textAlign: TextAlign.center)),
                  );
                }).toList()))));
  }
}

enum OrderType { MATRIX, SEQUENCE }