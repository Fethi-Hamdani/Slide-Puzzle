import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class Dashtar extends StatefulWidget {
  const Dashtar({Key? key}) : super(key: key);

  @override
  _DashtarState createState() => _DashtarState();
}

class _DashtarState extends State<Dashtar> {
  SMIBool? dance;

  void init(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'birb');

    artboard.addController(controller!);
    dance = controller.findInput<bool>('dance') as SMIBool;
  }

  void dance42seconds() {
    if (dance?.value == false) {
      setState(() {
        dance?.value = true;
        Future.delayed(Duration(seconds: 2), () {
          dance?.value = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var pro = Provider.of<BoardController>(context);
    pro.getDanceState().listen((event) {
      if (event) {
        pro.changeDance(false);
        dance42seconds();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dance42seconds();
      },
      child: RiveAnimation.asset(
        'assets/animations/birb.riv',
        onInit: init,
      ),
    );
  }
}
