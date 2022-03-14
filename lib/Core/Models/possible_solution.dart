import 'package:slidepuzzle/Core/Models/puzzle_board.dart';
import 'package:slidepuzzle/Core/Models/puzzle_tile.dart';

class PossibleSolution {
  PuzzleBoard board;
  List<PuzzleTile> moves = [];
  PossibleSolution({
    required this.board,
    required this.moves,
  });

  void addMove(PuzzleTile move) {
    moves.add(move);
  }

  factory PossibleSolution.clone(PossibleSolution source) {
    return PossibleSolution(
        board: source.board,
        moves: source.moves.map((e) => PuzzleTile.clone(e)).toList());
  }
  bool get isCorrect {
    return board.tiles.every((element) => element.isAtrightPlace);
  }

  @override
  String toString() => 'board: $board,\n moves: $moves \n';
}
