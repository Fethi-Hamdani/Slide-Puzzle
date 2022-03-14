import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleStatsBar extends StatefulWidget {
  final double fontSize;
  const PuzzleStatsBar({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  _PuzzleStatsBarState createState() => _PuzzleStatsBarState();
}

class _PuzzleStatsBarState extends State<PuzzleStatsBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      small: Container(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                    height: 25,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
      medium: Container(
        constraints: const BoxConstraints(
            maxHeight: 30, minHeight: 25, maxWidth: 280, minWidth: 180),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
      large: Container(
        constraints: const BoxConstraints(
            maxHeight: 30, minHeight: 25, maxWidth: 280, minWidth: 180),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        child: Consumer<BoardController>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: value.moves.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Moves',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: value.tilesLeft.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading18
                        .copyWith(fontSize: widget.fontSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Tiles',
                        style: AppTextStyles.heading16
                            .copyWith(fontSize: widget.fontSize - 2),
                      )
                    ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
