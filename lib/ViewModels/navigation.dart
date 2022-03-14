import 'package:flutter/cupertino.dart';
import 'package:slidepuzzle/Core/Enums/stage.dart';

class Navigation extends ChangeNotifier {
  Stage game = Stage.Casual;

  void switchStage(Stage stage, Function function) {
    if (stage != game) {
      game = stage;
      function();
      notifyListeners();
    }
  }
}
