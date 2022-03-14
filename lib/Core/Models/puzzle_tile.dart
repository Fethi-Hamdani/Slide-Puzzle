import 'package:flutter/cupertino.dart';

const List<String> alphabets = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

class PuzzleTile {
  int index;
  bool isEmptyTile;
  int correctIndex;
  Offset offset;
  Widget? image;

  PuzzleTile({
    required this.index,
    this.isEmptyTile = false,
    required this.correctIndex,
    required this.offset,
    this.image,
  });

  String name({bool alphabet = false}) {
    return alphabet ? alphabets[correctIndex] : (correctIndex + 1).toString();
  }
  factory PuzzleTile.clone(PuzzleTile source) {
    return PuzzleTile(
      correctIndex: source.correctIndex,
      index: source.index,
      offset: source.offset,
      isEmptyTile: source.isEmptyTile,
      image: source.image,
    );
  }
  bool get isAtrightPlace => index == correctIndex;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PuzzleTile &&
        other.index == index &&
        other.isEmptyTile == isEmptyTile &&
        other.correctIndex == correctIndex &&
        other.offset == offset &&
        other.image == image &&
        other.name == name;
  }

  @override
  String toString() {
    return isEmptyTile ? 'name: X' : 'name: $name';
  }
}
