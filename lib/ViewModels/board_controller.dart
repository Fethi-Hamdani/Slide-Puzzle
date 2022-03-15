import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as im;
import 'package:slidepuzzle/Core/Models/puzzle_board.dart';
import 'package:slidepuzzle/Core/Models/puzzle_tile.dart';
import 'package:slidepuzzle/Core/Models/score.dart';
import 'package:slidepuzzle/Core/Models/solver.dart';
import 'package:slidepuzzle/Core/services/audio.dart';
import 'package:slidepuzzle/Core/services/dialogs.dart';

class BoardController extends ChangeNotifier {
  late PuzzleBoard board;
  bool busy = false;
  bool isAlphabet = false;
  bool showEndDialog = false;
  bool isSolving = false;
  bool botSolved = false;
  int numberOfPossibleSolutions = 0;
  int switchesLeft = 5;
  bool switchingSlides = false;
  List<PuzzleTile> toSwitch = [];
  Uint8List? bytesFromPicker;
  bool showCountDown = false;
  bool dashdance = false;

  Stopwatch timer = Stopwatch();
  Duration tilesMoveAnimationDuration = const Duration(milliseconds: 200);

  bool get shouldShowResetDialog {
    return (board.moves.isNotEmpty || timer.isRunning) &&
        !board.isPuzzleSolved(board.tiles);
  }

  void changeDance(bool value) {
    dashdance = value;
    notifyListeners();
  }

  void changeAlhphabt() {
    isAlphabet = !isAlphabet;
    notifyListeners();
  }

  Stream<bool> getDanceState() async* {
    yield dashdance;
  }

  void showDialog({required BuildContext context}) {
    Score score =
        Score(time: Duration(seconds: timer.elapsed.inSeconds), moves: moves);
    PuzzleDialog().gameEnded(context: context, score: score);
    endDialogAlreeadyShown();
  }

  void gameEnded() {
    bool res = board.isPuzzleSolved(board.tiles);
    if (res) {
      timer.stop();
      AppAudio().gameEnded();
      notifyListeners();
    }
  }

  bool get isCurrentlyPlaying {
    return timer.isRunning;
  }

  int get moves {
    return board.moves.length;
  }

  void init({required double width}) {
    board = PuzzleBoard(size: 3, width: width);
  }

  int get tilesLeft {
    return board.boardSize - board.correctTilesCount - 1;
  }

  void startGame() {
    if (!busy) {
      resetGame();
      tilesMoveAnimationDuration = Duration(milliseconds: 600);
      busy = true;
      notifyListeners();

      Future.delayed(Duration(seconds: 1), () {
        showCountDown = true;
        AppAudio().gameStarted();
        notifyListeners();
      });

      Timer t = Timer.periodic(Duration(seconds: 1), (val) {
        board.scrumbleBoard(val.tick == 3);
        notifyListeners();
        if (val.tick == 3) {
          val.cancel();
          Future.delayed(tilesMoveAnimationDuration, () {
            tilesMoveAnimationDuration = Duration(milliseconds: 200);
            busy = false;
            timer.start();
            notifyListeners();
          });
        }
      });
    }
  }

  void hideTextAnimation() {
    showCountDown = false;
    notifyListeners();
  }

  void endDialogAlreeadyShown() {
    showEndDialog = false;
    notifyListeners();
  }

  void resetGame() {
    board.moves = [];
    botSolved = false;
    showEndDialog = true;
    timer.stop();
    timer.reset();
    switchesLeft = 5;
    notifyListeners();
  }

  double get boardSize {
    return board.size * board.tileSize + (board.tilemargin * (board.size - 1));
  }

  void tileClicked(PuzzleTile tile) {
    if (!busy && isCurrentlyPlaying && !switchingSlides) {
      board.tilePressed(tile);
      notifyListeners();
      gameEnded();
    }
    if (switchingSlides) {
      switchTiles(tile);
      notifyListeners();
      gameEnded();
    }
  }

  void changeSize(int size) {
    if (!busy && size != board.size) {
      resetGame();
      tilesMoveAnimationDuration = Duration(milliseconds: 600);
      busy = true;
      board = PuzzleBoard(size: size, width: board.width, image: board.image);
      notifyListeners();
      Future.delayed(tilesMoveAnimationDuration, () {
        tilesMoveAnimationDuration = Duration(milliseconds: 200);
        busy = false;
        notifyListeners();
      });
    }
  }

  void changeImageToBoard() {
    if (!busy) {
      resetGame();
      tilesMoveAnimationDuration = Duration(milliseconds: 600);
      busy = true;
      board = PuzzleBoard(size: board.size, width: board.width, image: null);
      notifyListeners();
      Future.delayed(tilesMoveAnimationDuration, () {
        tilesMoveAnimationDuration = Duration(milliseconds: 200);
        busy = false;
        notifyListeners();
      });
    }
  }

  Future<void> changeBoardToImage() async {
    if (!busy) {
      resetGame();
      tilesMoveAnimationDuration = Duration(milliseconds: 600);
      busy = true;

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        File file = File(result.files.single.path!);
        bytesFromPicker = await file.readAsBytesSync();
        await compute(im.decodeImage, bytesFromPicker!).then((value) {
          board =
              PuzzleBoard(size: board.size, width: board.width, image: value!);
        });
        //  im.Image img = await im.decodeImage(bytesFromPicker!)!;

        notifyListeners();
        Future.delayed(tilesMoveAnimationDuration, () {
          tilesMoveAnimationDuration = Duration(milliseconds: 200);
          busy = false;
          notifyListeners();
        });
      } else {
        // User canceled the picker
      }
    }
  }

  Future<Uint8List> readNetworkImage(String imageUrl) async {
    http.Response response = await http.get(
      Uri.parse(imageUrl),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
    return response.bodyBytes;
  }

  void toggleSwitchTiles() {
    if (!busy && isCurrentlyPlaying && switchesLeft != 0) {
      switchingSlides = !switchingSlides;
      notifyListeners();
    }
  }

  void switchTiles(PuzzleTile tile) {
    if (!toSwitch.contains(tile)) {
      toSwitch.add(tile);
      if (toSwitch.length == 2) {
        board.switchTiles(start: toSwitch[0], end: toSwitch[1], sound: true);
        switchingSlides = false;
        switchesLeft--;
        toSwitch.clear();
      }
      notifyListeners();
    } else {
      toSwitch.remove(tile);
      notifyListeners();
    }
  }

  Future<void> solvePuzzle() async {
    isSolving = true;
    botSolved = true;
    numberOfPossibleSolutions = 0;
    notifyListeners();
    await animateSolution(
        await PuzzleSolver().solve(board: PuzzleBoard.clone(board)));
    isSolving = false;
    notifyListeners();
  }

  Future<void> animateSolution(List<PuzzleTile> tiles) async {
    numberOfPossibleSolutions = tiles.length;
    notifyListeners();
    print("final moves are " + tiles.toString());
    for (var move in tiles) {
      if (tiles.indexOf(move) == 0) {
        tileClicked(move);
        numberOfPossibleSolutions--;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          tileClicked(move);
          numberOfPossibleSolutions--;
        });
      }
    }
    numberOfPossibleSolutions = tiles.length;
  }
}
