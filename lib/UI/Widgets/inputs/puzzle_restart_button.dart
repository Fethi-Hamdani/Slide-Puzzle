import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/Core/services/dialogs.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzzleRestartButton extends StatefulWidget {
  const PuzzzleRestartButton({Key? key}) : super(key: key);

  @override
  _PuzzzleRestartButtonState createState() => _PuzzzleRestartButtonState();
}

class _PuzzzleRestartButtonState extends State<PuzzzleRestartButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      small: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
            onHover: (value) {
              setState(() {
                hover = value;
              });
            },
            style: ButtonStyle(
                textStyle:
                    MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
                  fontSize: 16,
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
              if (Provider.of<BoardController>(context, listen: false)
                  .shouldShowResetDialog) {
                PuzzleDialog().gameRest(
                    context: context,
                    confirm:
                        Provider.of<BoardController>(context, listen: false)
                            .startGame);
              } else {
                Provider.of<BoardController>(context, listen: false)
                    .startGame();
              }
            },
            child: Consumer<BoardController>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: !value.isCurrentlyPlaying
                    ? const [
                        Icon(
                          FeatherIcons.play,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Begin",
                        ),
                      ]
                    : const [
                        Icon(
                          FeatherIcons.refreshCcw,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Restart"),
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
                textStyle:
                    MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
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
              if (Provider.of<BoardController>(context, listen: false)
                  .shouldShowResetDialog) {
                PuzzleDialog().gameRest(
                    context: context,
                    confirm:
                        Provider.of<BoardController>(context, listen: false)
                            .startGame);
              } else {
                Provider.of<BoardController>(context, listen: false)
                    .startGame();
              }
            },
            child: Consumer<BoardController>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: !value.isCurrentlyPlaying
                    ? const [
                        Icon(
                          FeatherIcons.play,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Begin",
                        ),
                      ]
                    : const [
                        Icon(
                          FeatherIcons.refreshCcw,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Restart"),
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
                textStyle:
                    MaterialStateProperty.all<TextStyle>(GoogleFonts.montserrat(
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
              if (Provider.of<BoardController>(context, listen: false)
                  .shouldShowResetDialog) {
                PuzzleDialog().gameRest(
                    context: context,
                    confirm:
                        Provider.of<BoardController>(context, listen: false)
                            .startGame);
              } else {
                Provider.of<BoardController>(context, listen: false)
                    .startGame();
              }
            },
            child: Consumer<BoardController>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: !value.isCurrentlyPlaying
                    ? const [
                        Icon(
                          FeatherIcons.play,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Begin",
                        ),
                      ]
                    : const [
                        Icon(
                          FeatherIcons.refreshCcw,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Restart"),
                      ],
              );
            })),
      ),
    );
  }
}
