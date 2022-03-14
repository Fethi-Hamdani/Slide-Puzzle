import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleSolveButton extends StatefulWidget {
  const PuzzleSolveButton({Key? key}) : super(key: key);

  @override
  _PuzzzleRestartButtonState createState() => _PuzzzleRestartButtonState();
}

class _PuzzzleRestartButtonState extends State<PuzzleSolveButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        small: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ElevatedButton(
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  )),
                  animationDuration: const Duration(milliseconds: 100),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primary2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side:
                              BorderSide(color: AppColors.primary2, width: 2))),
                  shadowColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed: () {
                Provider.of<BoardController>(context, listen: false)
                    .solvePuzzle();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Icon(value.isSolving
                        ? Icons.timelapse_rounded
                        : Icons.pattern_sharp),
                    Spacer(),
                  ],
                );
              })),
        ),
        medium: Container(
          constraints: const BoxConstraints(
              maxHeight: 55, minHeight: 40, maxWidth: 180, minWidth: 150),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.05,
          child: ElevatedButton(
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  )),
                  animationDuration: const Duration(milliseconds: 100),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                  backgroundColor: hover
                      ? MaterialStateProperty.all<Color>(AppColors.primary3)
                      : MaterialStateProperty.all<Color>(AppColors.primary1)),
              onPressed: () {
                Provider.of<BoardController>(context, listen: false)
                    .solvePuzzle();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(value.isSolving
                        ? "Solving.."
                        : value.numberOfPossibleSolutions > 0
                            ? "Solved in "
                            : "Solve"),
                    Spacer(),
                    if (value.numberOfPossibleSolutions > 0)
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            value.numberOfPossibleSolutions.toString(),
                            style: TextStyle(color: AppColors.primary1),
                          )),
                  ],
                );
              })),
        ),
        large: Container(
          constraints: const BoxConstraints(
              maxHeight: 55, minHeight: 40, maxWidth: 180, minWidth: 150),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.05,
          child: ElevatedButton(
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  )),
                  animationDuration: const Duration(milliseconds: 100),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                  backgroundColor: hover
                      ? MaterialStateProperty.all<Color>(AppColors.primary3)
                      : MaterialStateProperty.all<Color>(AppColors.primary1)),
              onPressed: () {
                Provider.of<BoardController>(context, listen: false)
                    .solvePuzzle();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(value.isSolving
                        ? "Solving.."
                        : value.numberOfPossibleSolutions > 0
                            ? "Solved in "
                            : "Solve"),
                    Spacer(),
                    if (value.numberOfPossibleSolutions > 0)
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            value.numberOfPossibleSolutions.toString(),
                            style: TextStyle(color: AppColors.primary1),
                          )),
                  ],
                );
              })),
        ));
  }
}
