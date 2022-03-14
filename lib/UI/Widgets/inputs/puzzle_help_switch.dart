import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleHelpSwitch extends StatefulWidget {
  const PuzzleHelpSwitch({
    Key? key,
  }) : super(key: key);

  @override
  _PuzzleHelpSwitch createState() => _PuzzleHelpSwitch();
}

class _PuzzleHelpSwitch extends State<PuzzleHelpSwitch> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(builder: (context, value, child) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 40,
        width: hover ? 150 : 50,
        child: ElevatedButton(
            onPressed: () {
              value.board.solvePuzzle(input: value.board.tiles);
            },
            onHover: (value) {
              setState(() {
                hover = value;
              });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
                backgroundColor: hover
                    ? MaterialStateProperty.all<Color>(AppColors.primary3)
                    : MaterialStateProperty.all<Color>(AppColors.primary1)),
            child: Text("Solve " +
                value.board.isPuzzleSolved(value.board.tiles).toString())),
      );
    });
  }
}
