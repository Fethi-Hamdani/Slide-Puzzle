import 'package:slidepuzzle/Core/Models/possible_solution.dart';
import 'package:slidepuzzle/Core/Models/puzzle_board.dart';
import 'package:slidepuzzle/Core/Models/puzzle_tile.dart';

class PuzzleSolver {
  Future<List<PuzzleTile>> solve({required PuzzleBoard board}) async {
    return await AstarAlgorithm(board: board);
  }

  PuzzleBoard switchTilesinBoard(
      {required PuzzleBoard stage,
      required PuzzleTile start,
      required PuzzleTile end}) {
    int index = start.index;
    PuzzleBoard clone = PuzzleBoard.clone(stage);
    clone
        .tiles[clone.tiles
            .lastIndexWhere((element) => element.name() == start.name())]
        .index = end.index;

    clone
        .tiles[clone.tiles
            .lastIndexWhere((element) => element.name() == end.name())]
        .index = index;
    return clone;
  }

  List<PossibleSolution> makeMove({required PossibleSolution attempt}) {
    List<PossibleSolution> res = [];
    List<PuzzleTile> moves =
        attempt.board.getPossibleMoves(board: attempt.board);

    for (var move in moves) {
      PuzzleTile empty = PuzzleBoard.clone(attempt.board)
          .emptyTile(PuzzleBoard.clone(attempt.board));

      PossibleSolution tryy = PossibleSolution(
          moves: [...attempt.moves.map((e) => PuzzleTile.clone(e)).toList(),move],
          board: PuzzleBoard.clone(switchTilesinBoard(
              stage: PuzzleBoard.clone(attempt.board),
              start: PuzzleTile.clone(move),
              end: PuzzleTile.clone(empty))));

      res.add(tryy);
    }

    return res.toList();
  }

  Future<List<PuzzleTile>> AstarAlgorithm({required PuzzleBoard board}) async {
    List<PuzzleTile> moves = board.getPossibleMoves(board: board);

    List<PossibleSolution> totallMoves = [];
    List<PossibleSolution> tempMoves = [];

    /*   totallMoves.addAll(moves.map((e) {
      return PossibleSolution(board: board, moves: [e]);
    })); */

    int i = 0;
    while (i <= 20) {
      print("iteration ${i + 1}");
      if (totallMoves.isEmpty) {
        tempMoves = makeMove(
            attempt:
                PossibleSolution(board: PuzzleBoard.clone(board), moves: []));
      } else {
        tempMoves = [];
        for (var item in totallMoves) {
          tempMoves.addAll(makeMove(attempt: item));
        }
      }

      totallMoves = tempMoves.toList();

      for (var item in totallMoves) {
        if (item.isCorrect) {
          print('correct item is');
          print(item.moves.map((e) => e.name()).toList());
          List<PuzzleTile> solutions = item.moves.toList();
          List<PuzzleTile> res = [];
          for (var i = 0; i < solutions.length - 1; i++) {
            if (solutions[i].index == solutions[i + 1].index) {
              continue;
            } else {
              res.add(solutions[i]);
            }
          }

          res.add(solutions.last);
          //
          return res;
        }
      }

      /*  print("iteration " + i.toString());
      for (var move in totallMoves) {
        await Future.delayed(Duration.zero);
        PuzzleTile empty = board.emptyTile(move.board);
        PuzzleBoard temp = PuzzleBoard.clone(move.board);
        temp = PuzzleBoard.clone(switchTilesinBoard(
            stage: PuzzleBoard.clone(temp),
            start: PuzzleTile.clone(move.moves.last),
            end: PuzzleTile.clone(empty)));
        List<PuzzleTile> nextMoves = PuzzleBoard.clone(temp)
            .getPossibleMoves(board: PuzzleBoard.clone(temp));

        for (var item in nextMoves) {
          if (move.moves.last.name != item.name) {
            PossibleSolution mv = PossibleSolution(
                board: PuzzleBoard.clone(temp), moves: [...move.moves, item]);
            PuzzleTile empty = PuzzleTile.clone(
                mv.board.emptyTile(PuzzleBoard.clone(mv.board)));
            temp = PuzzleBoard.clone(switchTilesinBoard(
                stage: PuzzleBoard.clone(mv.board),
                start: PuzzleTile.clone(mv.moves.last),
                end: PuzzleTile.clone(empty)));

            if (temp.isPuzzleSolved(temp.tiles) || mv.isCorrect) {
              return mv.moves;
            }
            tempMoves.add(mv);
          }
        }
      }
      totallMoves = tempMoves.map((e) => PossibleSolution.clone(e)).toList(); */
      i++;
    }

    return [];
  }
}
