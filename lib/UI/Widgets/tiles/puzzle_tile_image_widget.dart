// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/Core/Models/puzzle_tile.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class ImageTile extends StatefulWidget {
  PuzzleTile tile;
  ImageTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<ImageTile> with TickerProviderStateMixin {
  bool hover = false;
  double margin = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardController>(builder: (context, value, child) {
      double size = value.board.tileSize;
      return AnimatedPositioned(
          duration: value.tilesMoveAnimationDuration,
          top: widget.tile.offset.dy,
          left: widget.tile.offset.dx,
          child: widget.tile.isEmptyTile
              ? SizedBox()
              : SizedBox(
                  width: size,
                  height: size,
                  child: ElevatedButton(
                    onHover: (val) {
                      setState(() {
                        if (value.isCurrentlyPlaying) {
                          hover = val;
                          margin = value.board.tilemargin / 2;
                        }
                      });
                    },
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 200),
                      scale: hover ? ((size + margin) / size) : 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.tile.image,
                      ),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent)),
                    onPressed: () {
                      setState(() {
                        value.tileClicked(widget.tile);
                      });
                    },
                  ),
                ));
    });
  }
}
