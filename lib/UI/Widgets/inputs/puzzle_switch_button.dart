import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleSwitchButton extends StatefulWidget {
  const PuzzleSwitchButton({Key? key}) : super(key: key);

  @override
  _PuzzzleRestartButtonState createState() => _PuzzzleRestartButtonState();
}

class _PuzzzleRestartButtonState extends State<PuzzleSwitchButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    /*
    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.switchesLeft.toString(),
                          style: TextStyle(
                              color: AppColors.primary1, fontSize: 15),
                        )),
    */
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
                    .toggleSwitchTiles();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.swipe_sharp,
                    ),
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
                      : MaterialStateProperty.all<Color>(AppColors.primary2)),
              onPressed: () {
                Provider.of<BoardController>(context, listen: false)
                    .toggleSwitchTiles();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(value.switchingSlides ? "Switching..." : "Switch"),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.switchesLeft.toString(),
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
                      : MaterialStateProperty.all<Color>(AppColors.primary2)),
              onPressed: () {
                Provider.of<BoardController>(context, listen: false)
                    .toggleSwitchTiles();
              },
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(value.switchingSlides ? "Switching..." : "Switch"),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.switchesLeft.toString(),
                          style: TextStyle(color: AppColors.primary1),
                        )),
                  ],
                );
              })),
        ));
  }
}
