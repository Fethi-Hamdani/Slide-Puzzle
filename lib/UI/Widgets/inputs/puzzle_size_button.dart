import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/Core/services/dialogs.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleSizeButton extends StatefulWidget {
  final int size;
  const PuzzleSizeButton({Key? key, required this.size}) : super(key: key);

  @override
  _PuzzleSizeButtonState createState() => _PuzzleSizeButtonState();
}

class _PuzzleSizeButtonState extends State<PuzzleSizeButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(builder: (context, value, child) {
      bool enabled = value.board.size == widget.size;
      return ResponsiveWidget(
        small: SizedBox(
          width: 40,
          child: TextButton(
              onPressed: () {
                if (Provider.of<BoardController>(context, listen: false)
                    .shouldShowResetDialog) {
                  PuzzleDialog().gameRest(
                      context: context,
                      confirm: () {
                        Provider.of<BoardController>(context, listen: false)
                            .changeSize(widget.size);
                      });
                } else {
                  Provider.of<BoardController>(context, listen: false)
                      .changeSize(widget.size);
                }
              },
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (widget.size * widget.size - 1).toString(),
                    style: enabled
                        ? AppTextStyles.appbarEnabled.copyWith(fontSize: 18)
                        : AppTextStyles.appbarDisabled.copyWith(fontSize: 17),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    decoration: BoxDecoration(
                        color: AppColors.primary1,
                        borderRadius: BorderRadius.circular(15)),
                    width:
                        enabled ? MediaQuery.of(context).size.width * 0.05 : 0,
                  )
                ],
              )),
        ),
        medium: SizedBox(
          height: 40,
          width: 40,
          child: ElevatedButton(
              onPressed: () {
                if (Provider.of<BoardController>(context, listen: false)
                    .shouldShowResetDialog) {
                  PuzzleDialog().gameRest(
                      context: context,
                      confirm: () {
                        Provider.of<BoardController>(context, listen: false)
                            .changeSize(widget.size);
                      });
                } else {
                  Provider.of<BoardController>(context, listen: false)
                      .changeSize(widget.size);
                }
              },
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              style: enabled
                  ? ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      backgroundColor: hover
                          ? MaterialStateProperty.all<Color>(AppColors.primary3)
                          : MaterialStateProperty.all<Color>(
                              AppColors.primary2))
                  : ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(
                          color:
                              hover ? AppColors.primary1 : AppColors.primary3,
                          width: 2)),
                      animationDuration: const Duration(milliseconds: 100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: hover
                          ? MaterialStateProperty.all<Color>(Colors.white)
                          : MaterialStateProperty.all<Color>(
                              AppColors.primary3),
                      backgroundColor: hover ? MaterialStateProperty.all<Color>(AppColors.primary1) : MaterialStateProperty.all<Color>(Colors.white)),
              child: Text((widget.size * widget.size - 1).toString())),
        ),
        large: SizedBox(
          height: 40,
          width: 40,
          child: ElevatedButton(
              onPressed: () {
                if (Provider.of<BoardController>(context, listen: false)
                    .shouldShowResetDialog) {
                  PuzzleDialog().gameRest(
                      context: context,
                      confirm: () {
                        Provider.of<BoardController>(context, listen: false)
                            .changeSize(widget.size);
                      });
                } else {
                  Provider.of<BoardController>(context, listen: false)
                      .changeSize(widget.size);
                }
              },
              onHover: (value) {
                setState(() {
                  hover = value;
                });
              },
              style: enabled
                  ? ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      backgroundColor: hover
                          ? MaterialStateProperty.all<Color>(AppColors.primary3)
                          : MaterialStateProperty.all<Color>(
                              AppColors.primary2))
                  : ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(
                          color:
                              hover ? AppColors.primary1 : AppColors.primary3,
                          width: 2)),
                      animationDuration: const Duration(milliseconds: 100),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor: hover
                          ? MaterialStateProperty.all<Color>(Colors.white)
                          : MaterialStateProperty.all<Color>(
                              AppColors.primary3),
                      backgroundColor: hover ? MaterialStateProperty.all<Color>(AppColors.primary1) : MaterialStateProperty.all<Color>(Colors.white)),
              child: Text((widget.size * widget.size - 1).toString())),
        ),
      );
    });
  }
}
