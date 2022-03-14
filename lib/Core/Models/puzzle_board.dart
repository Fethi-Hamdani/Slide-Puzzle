import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as im;
import 'package:slidepuzzle/Core/Models/move.dart';
import 'package:slidepuzzle/Core/Models/slide.dart';
import 'package:slidepuzzle/Core/services/audio.dart';

import 'puzzle_tile.dart';

class PuzzleBoard {
  List<PuzzleTile> tiles = [];
  List<PuzzleTile> solution = [];
  int size;
  double width;
  List<Move> moves = [];
  im.Image? image;
  PuzzleBoard({
    required this.size,
    required this.width,
    this.image,
    List<PuzzleTile>? tiles,
    List<Move>? moves,
  }) {
    if (moves != null) {
      this.moves = moves;
    }
    if (tiles != null) {
      this.tiles = tiles;
    } else {
      initBoard(image);
    }
  }
  factory PuzzleBoard.clone(PuzzleBoard source) {
    return PuzzleBoard(
        size: source.size,
        width: source.width,
        image: source.image,
        moves: source.moves.map((e) => Move.clone(e)).toList(),
        tiles: source.tiles.map((e) => PuzzleTile.clone(e)).toList());
  }

  double get tileSize {
    return (width - (tilemargin * (size + 1))) / size;
  }

  double get tilemargin {
    return 10;
  }

  int get correctTilesCount {
    return tiles
        .where((element) =>
            element.index != boardSize - 1 &&
            element.index == element.correctIndex)
        .toList()
        .length;
  }

  Future<void> initBoard(im.Image? image) async {
    double space = tileSize + tilemargin;
    int dx = 0;
    Widget? widget;
    if (image != null) {
      image = im.copyResize(image, height: width.round(), width: width.round());
    }
    for (var i = 0; i < boardSize; i = i + size) {
      for (var j = 0; j < size; j++) {
        int index = j + i;
        if (index != boardSize - 1) {
          im.Image? img;
          if (image != null) {
            print("image is not null showing image");
            img = im.copyCrop(image, (space * j).round(), (space * dx).round(),
                tileSize.round(), tileSize.round());
            widget = Image.memory(im.encodePng(img) as Uint8List);
          }
          tiles.add(PuzzleTile(
              correctIndex: index,
              index: index,
              image: widget,
              offset: Offset(space * j + tilemargin, space * dx + tilemargin)));
        } else {
          tiles.add(PuzzleTile(
              correctIndex: boardSize - 1,
              index: boardSize - 1,
              isEmptyTile: true,
              offset: Offset(space * j + tilemargin, space * dx + tilemargin)));
        }
      }
      dx++;
    }
  }

  void scrumbleBoard(bool checkSolve) {
    // switchTiles(start: tiles[boardSize - 2], end: tiles[boardSize - 1]);
    // switchTiles(start: tiles[boardSize - 3], end: tiles[boardSize - 2]);
    // switchTiles(start: tiles[boardSize - 6], end: tiles[boardSize - 3]);

    List<int> indexes = List.generate(boardSize, (index) => index);
    indexes.remove(boardSize - 1);

    PuzzleTile empty = emptyTile(this);
    if (empty.index != boardSize - 1) {
      switchTiles(
          start: emptyTile(this),
          end: tiles.firstWhere((element) => element.index == boardSize - 1));
    }
    if (checkSolve) {
      do {
        indexes.shuffle();
      } while (!isSolvable(indexes));
    } else {
      indexes.shuffle();
    }

    int i = 0;
    while (i < indexes.length / 2) {
      /* if (indexes.last != tiles[i].correctIndex &&
          indexes.last != tiles[i].index) { */
      print('switched index from ${tiles[i].index} to ${indexes[i]} ');
      switchTiles(
          start: tiles[i],
          end: tiles.firstWhere((element) => element.index == indexes.last));
      indexes.removeLast();
      i++;
      /* } else {
        indexes.shuffle();
      } */
    }
  }

  void switchTiles(
      {required PuzzleTile start,
      required PuzzleTile end,
      bool sound = false}) {
    Offset md = start.offset;
    int index = start.index;
    start.index = end.index;
    start.offset = end.offset;
    end.offset = md;
    end.index = index;
    if (sound) {
      AppAudio().tileTransition();
      moves.add(
          Move(slides: [Slide(startIndex: start.index, endIndex: end.index)]));
    }
  }

  int getInvCount(List<int> items) {
    int inv_count = 0;
    List<List<int>> puzzle = [];
    for (var i = 0; i < boardSize; i = i + size) {
      puzzle.add(items.getRange(i, i + size).toList());
    }
    for (int i = 0; i < boardSize - 1; i++) {
      for (int j = i + 1; j < boardSize; j++) {
        // count pairs(arr[i], arr[j]) such that
        // i < j but arr[i] > arr[j]
        if (i < j && items[i] > items[j]) inv_count++;
      }
    }
    return inv_count;
  }

  int findXPosition(List<int> items) {
    List<List<int>> puzzle = [];
    for (var i = 0; i < boardSize; i = i + size) {
      puzzle.add(items.getRange(i, i + size).toList());
    }

    for (int i = size - 1; i >= 0; i--)
      for (int j = size - 1; j >= 0; j--)
        if (puzzle[i][j] == 0) return size - i;
    return boardSize - 1;
  }

  bool isSolvable(List<int> items) {
    print("intial indexes");
    /*  int invCount = getInvCount(items);

    // If grid is odd, return true if inversion
    // count is even.

    int pos = findXPosition(items);
    if (pos != 1)
      return !(invCount != 1);
    else
      return invCount != 1; */
    int i = 0;
    while (listEquals(items, [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
    ])) {
      int corindx = items.lastIndexWhere((element) => element == i);
      items[corindx] = items[i];
      items[i] = i;
      i++;
    }
    print(items);
    print("solvable " + (i % 2 == 0).toString());
    return i % 2 == 0;
  }

  PuzzleTile emptyTile(PuzzleBoard board) {
    return board.tiles.singleWhere((element) => element.isEmptyTile);
  }

  int get boardSize {
    return size * size;
  }

  bool isPuzzleSolved(List<PuzzleTile> board) {
    return board.every((element) => element.isAtrightPlace);
  }

  Slide? slideUp(PuzzleTile tile) {
    double up = tile.offset.dy - (tileSize + tilemargin);
    int index = tile.index - size;
    PuzzleTile empty = emptyTile(this);
    bool canMove = index == empty.index;
    if (canMove) {
      Slide slide = Slide(startIndex: tile.index, endIndex: index);
      empty.index = tile.index;
      empty.offset = tile.offset;
      tile.offset = Offset(tile.offset.dx, up);
      tile.index = index;
      return slide;
    }
  }

  Slide? slideDown(PuzzleTile tile) {
    double down = tile.offset.dy + (tileSize + tilemargin);
    int index = tile.index + size;
    PuzzleTile empty = emptyTile(this);
    bool canMove = index == empty.index;
    if (canMove) {
      Slide slide = Slide(startIndex: tile.index, endIndex: index);
      empty.index = tile.index;
      empty.offset = tile.offset;
      tile.offset = Offset(tile.offset.dx, down);
      tile.index = index;
      return slide;
    }
  }

  Slide? slideRight(PuzzleTile tile) {
    double right = tile.offset.dx + (tileSize + tilemargin);
    int index = tile.index + 1;
    PuzzleTile empty = emptyTile(this);
    bool canMove = index == empty.index;
    if (canMove) {
      Slide slide = Slide(startIndex: tile.index, endIndex: index);
      empty.index = tile.index;
      empty.offset = tile.offset;
      tile.offset = Offset(right, tile.offset.dy);
      tile.index = index;
      return slide;
    }
  }

  Slide? slideLeft(PuzzleTile tile) {
    double right = tile.offset.dx - (tileSize + tilemargin);
    int index = tile.index - 1;
    PuzzleTile empty = emptyTile(this);
    bool canMove = index == empty.index;
    if (canMove) {
      Slide slide = Slide(startIndex: tile.index, endIndex: index);
      empty.index = tile.index;
      empty.offset = tile.offset;
      tile.offset = Offset(right, tile.offset.dy);
      tile.index = index;
      return slide;
    }
  }

  checkRow(PuzzleTile tile) {
    PuzzleTile empty = emptyTile(this);
    int leftLimit = tile.index - tile.index % size;
    int rightLimit = leftLimit + size - 1;
    if (empty.index > tile.index) {
      List<PuzzleTile> colTiles = tiles
          .where((element) =>
              element.index >= leftLimit &&
              element.index < rightLimit &&
              element.index < empty.index &&
              element.index >= tile.index)
          .toList();
      colTiles.sort((a, b) => a.index.compareTo(b.index));
      List<Slide> slides = [];
      for (var item in colTiles.reversed.toList()) {
        Slide? slide = slideRight(item);
        if (slide != null) {
          slides.add(slide);
        }
      }
      if (slides.isNotEmpty) {
        AppAudio().tileTransition();
        moves.add(Move(slides: slides));
      }
    } else if (empty.index < tile.index) {
      List<PuzzleTile> colTiles = tiles
          .where((element) =>
              element.index > leftLimit &&
              element.index <= rightLimit &&
              element.index > empty.index &&
              element.index <= tile.index)
          .toList();
      colTiles.sort((a, b) => a.index.compareTo(b.index));
      List<Slide> slides = [];
      for (var item in colTiles) {
        Slide? slide = slideLeft(item);
        if (slide != null) {
          slides.add(slide);
        }
      }
      if (slides.isNotEmpty) {
        AppAudio().tileTransition();
        moves.add(Move(slides: slides));
      }
    }
  }

  checkColumn(PuzzleTile tile) {
    PuzzleTile empty = emptyTile(this);
    if (empty.index > tile.index) {
      List<PuzzleTile> colTiles = tiles
          .where((element) =>
              element.index % size == empty.index % size &&
              element.index < empty.index &&
              element.index >= tile.index)
          .toList();
      colTiles.sort((a, b) => a.index.compareTo(b.index));
      List<Slide> slides = [];
      for (var item in colTiles.reversed.toList()) {
        Slide? slide = slideDown(item);
        if (slide != null) {
          AppAudio().tileTransition();
          slides.add(slide);
        }
      }
      if (slides.isNotEmpty) {
        moves.add(Move(slides: slides));
      }
    } else {
      List<PuzzleTile> colTiles = tiles
          .where((element) =>
              element.index % size == empty.index % size &&
              element.index > empty.index &&
              element.index <= tile.index)
          .toList();
      colTiles.sort((a, b) => a.index.compareTo(b.index));
      List<Slide> slides = [];
      for (var item in colTiles) {
        Slide? slide = slideUp(item);
        if (slide != null) {
          AppAudio().tileTransition();
          slides.add(slide);
        }
      }
      if (slides.isNotEmpty) {
        moves.add(Move(slides: slides));
      }
    }
  }

  void tilePressed(PuzzleTile tile) {
    PuzzleTile empty = emptyTile(this);

    if (empty.index % size == tile.index % size) {
      checkColumn(tile);
    } else {
      checkRow(tile);
    }
  }

  void solvePuzzle(
      {List<PuzzleTile>? input, List<PuzzleTile> result = const []}) {
    List<PuzzleTile> board = input ?? tiles;
    if (solution.isNotEmpty || isPuzzleSolved(board)) {
      if (solution.isEmpty) {
        solution = result;
        print("result is ");
        print(result);
      }
    } else {
      PuzzleTile empty = emptyTile(this);
      for (var item in [possibleRows(board).last]) {
        print('looping with ${item.name}');
        tilePressed(item);
        solvePuzzle(result: [...result, item], input: board);
      }
      /*     for (var item in possibleColumns(board)) {
        solvePuzzle(
            result: [...result, item],
            input: switchTilesinBoard(board: board, start: item, end: empty));
      } */
    }
  }

  void switchTilesinBoard(
      {required List<PuzzleTile> stage,
      required PuzzleTile start,
      required PuzzleTile end}) {
    print("before " + stage.toString());

    int index = start.index;

    stage[stage.lastIndexWhere((element) => element.name == start.name)].index =
        end.index;

    stage[stage.lastIndexWhere((element) => element.name == end.name)].index =
        index;

    print("after " + stage.toString());
  }

  List<PuzzleTile> possibleColumns(List<PuzzleTile> board) {
    PuzzleTile empty = emptyTile(this);
    return board
        .where((element) =>
            element.index % size == empty.index % size &&
            element.index != empty.index)
        .toList();
  }

  List<PuzzleTile> possibleRows(List<PuzzleTile> board) {
    PuzzleTile empty = emptyTile(this);
    int leftLimit = empty.index - empty.index % size;
    int rightLimit = leftLimit + size - 1;
    return board
        .where((element) =>
            element.index >= leftLimit &&
            element.index <= rightLimit &&
            element.index != empty.index)
        .toList();
  }

  List<PuzzleTile> SV(PuzzleBoard board) {
    for (var item in possibleRows(board.tiles)) {
      PuzzleBoard tmpboard = board;
      print('looping with ${item.name}');
      tmpboard.tilePressed(item);
      if (tmpboard.isPuzzleSolved(tmpboard.tiles)) {
        return [item];
      }
    }
    for (var item in possibleRows(board.tiles)) {
      PuzzleBoard tmpboard = board;
      print('looping with ${item.name}');
      tmpboard.tilePressed(item);
      return [item, ...SV(tmpboard)];
    }
    return [];
  }

  // list length can be 2 / 3 / 4
  List<PuzzleTile> getPossibleMoves({required PuzzleBoard board}) {
    List<PuzzleTile> res = [];
    //   print("board is " + board.toString());
    // tiles passed to empty tile are not the same
    PuzzleTile empty = board.emptyTile(board);
    int leftLimit = empty.index - empty.index % size;
    int rightLimit = leftLimit + size - 1;
    // left
    if (leftLimit != empty.index) {
      res.add(board.tiles
          .firstWhere((element) => element.index == empty.index - 1));
    }
    // Right
    if (rightLimit != empty.index) {
      try {
        res.add(board.tiles
            .where((element) => element.index == empty.index + 1)
            .first);
      } catch (e) {
        print(
            "empty index is ${empty.index} right limit is $rightLimit index is " +
                (empty.index + 1).toString());
        print("error " + e.toString());
      }
    }
    if (empty.index + size < boardSize) {
      res.add(board.tiles
          .firstWhere((element) => element.index == empty.index + size));
    }

    if (empty.index - size >= 0) {
      res.add(board.tiles
          .firstWhere((element) => element.index == empty.index - size));
    }

    return res.map((e) => PuzzleTile.clone(e)).toList();
  }

  @override
  String toString() {
    List<PuzzleTile> sorted = tiles;
    sorted.sort(
      (a, b) => a.index.compareTo(b.index),
    );
    return '$sorted';
  }

  void printList(List<PuzzleTile> list) {
    List<PuzzleTile> sorted = list;
    sorted.sort(
      (a, b) => a.index.compareTo(b.index),
    );
    sorted.forEach((element) {
      print(element);
    });
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PuzzleBoard &&
        listEquals(other.tiles, tiles) &&
        listEquals(other.solution, solution) &&
        other.size == size &&
        other.width == width &&
        listEquals(other.moves, moves) &&
        other.image == image;
  }

  @override
  int get hashCode {
    return tiles.hashCode ^
        solution.hashCode ^
        size.hashCode ^
        width.hashCode ^
        moves.hashCode ^
        image.hashCode;
  }
}
