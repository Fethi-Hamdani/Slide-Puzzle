// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:slidepuzzle/Core/Models/puzzle_tile.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class Tile extends StatefulWidget {
  PuzzleTile tile;
  Tile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> with TickerProviderStateMixin {
  late RiveAnimationController correct = OneShotAnimation(
    'correct2',
    autoplay: false,
  );
  bool hover = false;
  double margin = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(builder: (context, value, child) {
      if (!value.toSwitch.contains(widget.tile)) {
        hover = false;
      }
      double size = value.board.tileSize;
      return AnimatedPositioned(
          duration: value.tilesMoveAnimationDuration,
          top: hover
              ? widget.tile.offset.dy - margin / 2
              : widget.tile.offset.dy,
          left: hover
              ? widget.tile.offset.dx - margin / 2
              : widget.tile.offset.dx,
          child: widget.tile.isEmptyTile
              ? EmptyTile()
              : AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: hover ? size + margin : size,
                  height: hover ? size + margin : size,
                  child: ElevatedButton(
                    onHover: (val) {
                      setState(() {
                        if (value.isCurrentlyPlaying &&
                            !value.toSwitch.contains(widget.tile)) {
                          hover = val;

                          margin = value.board.tilemargin / 2;
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        RiveAnimation.asset(
                          'assets/animations/puzzle_tile.riv',
                          controllers: [correct],
                        ),
                        Transform.scale(
                          scale: 2,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              widget.tile.name(alphabet: value.isAlphabet),
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              //    style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: AppColors.primary1, width: 3))),
                        backgroundColor: hover
                            ? MaterialStateProperty.all<Color>(
                                AppColors.primary3)
                            : MaterialStateProperty.all<Color>(
                                AppColors.primary2)),
                    onPressed: () {
                      setState(() {
                        hover = false;
                        value.tileClicked(widget.tile);
                        if (value.toSwitch.contains(widget.tile) &&
                            value.switchingSlides) {
                          hover = true;
                        }
                        if (widget.tile.isAtrightPlace) {
                          correct.isActive = true;
                          value.changeDance(true);
                        }
                        if (value.board.isPuzzleSolved(value.board.tiles) &&
                            value.showEndDialog) {
                          value.showDialog(context: context);
                        }
                      });
                    },
                  ),
                ));
    });
  }
}

class EmptyTile extends StatefulWidget {
  const EmptyTile({Key? key}) : super(key: key);

  @override
  _EmptyTileState createState() => _EmptyTileState();
}

class _EmptyTileState extends State<EmptyTile> {
  late RiveAnimationController empty = OneShotAnimation(
    'empty',
    autoplay: false,
  );

  void animate() {
    if (empty.isActive == false) {
      setState(() {
        empty.isActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(builder: (context, value, child) {
      double size = value.board.tileSize;
      return MouseRegion(
        onEnter: ((event) {
          animate();
        }),
        child: GestureDetector(
          onTap: () {
            animate();
          },
          child: SizedBox(
            width: size,
            height: size,
            child: RiveAnimation.asset(
              'assets/animations/puzzle_tile.riv',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              controllers: [empty],
            ),
          ),
        ),
      );
    });
  }
}
