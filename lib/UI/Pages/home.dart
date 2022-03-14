import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slidepuzzle/Core/Enums/stage.dart';
import 'package:slidepuzzle/Core/services/dialogs.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_restart_button.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_size_button.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_solve_button.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_switch_button.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_tile_tupe.dart';
import 'package:slidepuzzle/UI/Widgets/inputs/puzzle_type.dart';
import 'package:slidepuzzle/UI/Widgets/output/puzzle_stats_bar.dart';
import 'package:slidepuzzle/UI/Widgets/output/puzzle_stopwatch.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/UI/Widgets/rive/dashtar.dart';
import 'package:slidepuzzle/UI/Widgets/tiles/puzzle_tile_image_widget.dart';
import 'package:slidepuzzle/UI/Widgets/tiles/puzzle_tile_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';
import 'package:slidepuzzle/ViewModels/navigation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: FloatingActionButton(onPressed: () async {
            PuzzleDialog().gameInstructions(
              context: context,
            );
          }),
          body: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
                options: const ParticleOptions(
                  baseColor: Color.fromARGB(255, 67, 68, 68),
                  spawnOpacity: 0.0,
                  opacityChangeRate: 0.25,
                  minOpacity: 0.0,
                  maxOpacity: 0.4,
                  spawnMinSpeed: 30.0,
                  spawnMaxSpeed: 70.0,
                  spawnMinRadius: 2.0,
                  spawnMaxRadius: 8.0,
                  particleCount: 100,
                ),
                paint: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.0),
            vsync: this,
            child: Column(
              children: [
                ResponsiveWidget(
                    small: const SizedBox(),
                    medium: largeAppBar(),
                    large: largeAppBar()),
                ResponsiveWidget(
                    small: smallBottomSection(),
                    medium: mediumBottomSection(),
                    large: largeBottomSection()),
              ],
            ),
          )),
    );
  }

  Widget largeAppBar() {
    return Flexible(
        flex: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2),
          child: Consumer<Navigation>(builder: (context, value, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                PuzzleTypeButton(
                  stage: Stage.Casual,
                ),
                PuzzleTypeButton(
                  stage: Stage.Advanced,
                ),
                /* PuzzleTypeButton(
                  stage: Stage.Madness,
                ), */
              ],
            );
          }),
        ));
  }

  Widget largeBottomSection() {
    return Flexible(
        flex: 6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            largeLeftSection(),
            largeMiddleSection(),
            largeRightSection()
          ],
        ));
  }

  Widget mediumBottomSection() {
    return Flexible(
        flex: 6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            largeLeftSection(),
            largeMiddleSection(),
            largeRightSection()
          ],
        ));
  }

  Widget smallBottomSection() {
    return Flexible(
        flex: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            smallScreenTop(),
            smallScreenCenter(),
            smallScreenBottom(),
          ],
        ));
  }

  Widget largeLeftSection() {
    Widget casual = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Slide Puzzle\nHack',
          style: AppTextStyles.instructions.copyWith(color: Colors.black),
        ),
        const PuzzleStatsBar(fontSize: 18),
        const SizedBox(
          height: 10,
        ),
        const PuzzzleRestartButton(),
        const SizedBox(
          height: 10,
        ),
        const PuzzzleTileTypeButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            PuzzleSizeButton(
              size: 3,
            ),
            SizedBox(
              width: 20,
            ),
            PuzzleSizeButton(
              size: 4,
            ),
            SizedBox(
              width: 20,
            ),
            PuzzleSizeButton(
              size: 5,
            ),
          ],
        ),
      ],
    );

    Widget advanced = const Center(child: Text("Advanced page of the puzzle"));

    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.1,
            vertical: MediaQuery.of(context).size.width * 0.03),
        child: Consumer<Navigation>(builder: (context, value, child) {
          Widget widget;
          switch (value.game) {
            case Stage.Casual:
              widget = casual;
              break;
            case Stage.Advanced:
              widget = advanced;
              break;
            default:
              widget = casual;
          }

          return AnimatedSwitcher(
              child: casual, duration: const Duration(milliseconds: 500));
        }),
      ),
    );
  }

  Widget largeRightSection() {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * 0.05,
              vertical: MediaQuery.of(context).size.width * 0.03),
          child: Consumer<Navigation>(builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<BoardController>(
                  builder: (context, value, child) {
                    return Container(
                      width: value.board.width - value.board.tilemargin * 2,
                      height: value.board.width - value.board.tilemargin * 2,
                      child: value.bytesFromPicker != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(
                                value.bytesFromPicker!,
                                fit: BoxFit.fill,
                              ))
                          : const Dashtar(),
                    );
                  },
                ),
                const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    PuzzleSolveButton(),
                    SizedBox(
                      width: 10,
                    ),
                    PuzzleSwitchButton()
                  ],
                ),
              ],
            );
          }),
        ));
  }

  Widget largeMiddleSection() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 2,
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Center(
                  child: StopwatchTimer(
                    stopwatch: value.timer,
                  ),
                );
              })),
          Flexible(
            flex: 8,
            child: Center(
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: value.board.width,
                  height: value.board.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: List.generate(value.board.tiles.length, (index) {
                      return value.board.tiles[index].image != null
                          ? ImageTile(
                              tile: value.board.tiles[index],
                            )
                          : Tile(
                              tile: value.board.tiles[index],
                            );
                    }),
                  ),
                );
              }),
            ),
          ),
          Flexible(
              flex: 2,
              child:
                  Consumer<BoardController>(builder: (context, value, child) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: !value.showCountDown
                      ? const SizedBox()
                      : DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 70.0,
                          ),
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            pause: const Duration(milliseconds: 300),
                            onFinished: () {
                              value.hideTextAnimation();
                            },
                            animatedTexts: [
                              ScaleAnimatedText('1',
                                  duration: const Duration(milliseconds: 700)),
                              ScaleAnimatedText('2',
                                  duration: const Duration(milliseconds: 700)),
                              ScaleAnimatedText('3',
                                  duration: const Duration(milliseconds: 700)),
                              ScaleAnimatedText('Start!',
                                  duration: const Duration(milliseconds: 700)),
                            ],
                          ),
                        ),
                );
              }))
        ],
      ),
    );
  }

  Widget smallScreenTop() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            'Slide Puzzle Hack',
            style: AppTextStyles.instructions
                .copyWith(color: Colors.black, fontSize: 30, letterSpacing: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              PuzzleTypeButton(
                stage: Stage.Casual,
              ),
              SizedBox(
                height: 10,
              ),
              PuzzleTypeButton(
                stage: Stage.Advanced,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<BoardController>(builder: (context, value, child) {
            return Center(
              child: StopwatchTimer(
                stopwatch: value.timer,
              ),
            );
          })
        ],
      ),
    );
  }

  Widget smallScreenCenter() {
    return Expanded(
      flex: 5,
      child: Center(
        child: Consumer<BoardController>(builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: value.board.width,
            height: value.board.width,
            child: Stack(
              fit: StackFit.expand,
              children: List.generate(value.board.tiles.length, (index) {
                return value.board.tiles[index].image != null
                    ? ImageTile(
                        tile: value.board.tiles[index],
                      )
                    : Tile(
                        tile: value.board.tiles[index],
                      );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget smallScreenBottom() {
    return Expanded(
      flex: 3,
      child: Column(children: [
        const Spacer(),
        const PuzzleStatsBar(fontSize: 18),
        const SizedBox(
          height: 10,
        ),
        const PuzzzleRestartButton(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PuzzleSolveButton(),
            SizedBox(
              width: 10,
            ),
            PuzzleSwitchButton(),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<Navigation>(builder: (context, nav, child) {
              return Consumer<BoardController>(
                  builder: (context, value, child) {
                return nav.game == Stage.Advanced
                    ? IconButton(
                        onPressed: () {
                          value.changeBoardToImage();
                        },
                        icon: const Icon(Icons.image_search_rounded))
                    : IconButton(
                        onPressed: () {
                          value.changeAlhphabt();
                        },
                        icon: Text(
                          !value.isAlphabet ? "A" : "1",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ));
              });
            }),
            const Spacer(),
            const PuzzleSizeButton(
              size: 3,
            ),
            const SizedBox(
              width: 20,
            ),
            const PuzzleSizeButton(
              size: 4,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  PuzzleDialog().gameInstructions(
                    context: context,
                  );
                },
                icon: const Icon(
                  Icons.help_outline_rounded,
                  size: 28,
                )),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}
