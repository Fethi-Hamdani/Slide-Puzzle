import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/Core/Enums/stage.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';
import 'package:slidepuzzle/ViewModels/navigation.dart';

class PuzzzleTileTypeButton extends StatefulWidget {
  const PuzzzleTileTypeButton({Key? key}) : super(key: key);

  @override
  _PuzzzleRestartButtonState createState() => _PuzzzleRestartButtonState();
}

class _PuzzzleRestartButtonState extends State<PuzzzleTileTypeButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            if (Provider.of<Navigation>(context, listen: false).game ==
                Stage.Advanced) {
              Provider.of<BoardController>(context, listen: false)
                  .changeBoardToImage();
            } else {
              Provider.of<BoardController>(context, listen: false)
                  .changeAlhphabt();
            }
          },
          child: Consumer<BoardController>(builder: (context, value, child) {
            if (Provider.of<Navigation>(context, listen: false).game ==
                Stage.Advanced)
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.image,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Pick Image",
                    ),
                  ]);

            if (value.isAlphabet)
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.numbers,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Numbers",
                  ),
                ],
              );
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Alphabet",
                ),
              ],
            );
          })),
    );
  }
}
