import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:slidepuzzle/Core/Models/score.dart';
import 'package:slidepuzzle/Core/Models/user.dart';
import 'package:slidepuzzle/Core/services/device_id.dart';
import 'package:slidepuzzle/Core/services/firestore.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';
import 'package:slidepuzzle/ViewModels/board_controller.dart';

class PuzzleDialog {
  void editUser(
      {required BuildContext context, required Function(String) confirm}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: EditUser(
                  action: confirm,
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }

  void gameInstructions({required BuildContext context}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: const GameInstructions()),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }

  void gameRest({required BuildContext context, required Function() confirm}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: ResetGameDialog(
                  action: confirm,
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }

  void gameEnded({required BuildContext context, required Score score}) {
    var prov = Provider.of<BoardController>(context, listen: false);

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: ChangeNotifierProvider<BoardController>.value(
                value: prov,
                builder: (context, child) {
                  return GameEndedDialog(score: score);
                },
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });

/*     AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      animType: AnimType.SCALE,
      title: 'INFO',
      desc: 'Dialog description here...',
      showCloseIcon: true,
      customHeader: SDashtar(),
      btnCancelOnPress: () {},
      btnOkOnPress: () {},

    ).show(); */
  }
}

class GameInstructions extends StatefulWidget {
  const GameInstructions({Key? key}) : super(key: key);

  @override
  State<GameInstructions> createState() => _GameInstructionsState();
}

class _GameInstructionsState extends State<GameInstructions> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      large: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Just to let you know!',
              style: AppTextStyles.instructions
                  .copyWith(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: "this is a modern replication of the",
                    style: AppTextStyles.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                    children: [
                      TextSpan(
                        text: " Classic Slide puzzle",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: " it has various Sizes 3 , 4 and even 5 " +
                            "of alphabetical or numerical tiles and if you to go even advanced you can import your own images and have fun with them  ",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 16),
                      )
                    ])),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Switch ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.swipe),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "use Switch to swap 2 tiles to there correct place keep in mind that you have 5 tries only.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Solve ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 18,
                ),
                const Icon(Icons.pattern_sharp),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "when stressed out use Solve to unlock the puzzle, the more moves it takes to solve the longer the time to solve it.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      medium: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Just to let you know!',
              style: AppTextStyles.instructions
                  .copyWith(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: "this is a modern replication of the",
                    style: AppTextStyles.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                    children: [
                      TextSpan(
                        text: " Classic Slide puzzle",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: " it has various Sizes 3 , 4 and even 5 " +
                            "of alphabetical or numerical tiles and if you to go even advanced you can import your own images and have fun with them  ",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 16),
                      )
                    ])),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Switch ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.swipe),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "use Switch to swap 2 tiles to there correct place keep in mind that you have 5 tries only.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Solve ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 18,
                ),
                const Icon(Icons.pattern_sharp),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "when stressed out use Solve to unlock the puzzle, the more moves it takes to solve the longer the time to solve it.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      small: AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Just to let you know!',
              style: AppTextStyles.instructions
                  .copyWith(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: "this is a modern replication of the",
                    style: AppTextStyles.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                    children: [
                      TextSpan(
                        text: " Classic Slide puzzle",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      TextSpan(
                        text: " it has various Sizes 3 , 4 and even 5 " +
                            "of alphabetical or numerical tiles and if you to go even advanced you can import your own images and have fun with them  ",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 16),
                      )
                    ])),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Switch ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.swipe),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "use Switch to swap 2 tiles to there correct place keep in mind that you have 5 tries only.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Solve ',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  width: 18,
                ),
                const Icon(Icons.pattern_sharp),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "when stressed out use Solve to unlock the puzzle, the more moves it takes to solve the longer the time to solve it.",
                textAlign: TextAlign.justify,
                style: AppTextStyles.heading16.copyWith(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class GameEndedDialog extends StatefulWidget {
  final Score score;
  const GameEndedDialog({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  State<GameEndedDialog> createState() => _GameEndedDialogState();
}

class _GameEndedDialogState extends State<GameEndedDialog> {
  late int minutes, seconds;
  @override
  void initState() {
    super.initState();
    minutes = widget.score.time.inMinutes % 60;
    seconds = widget.score.time.inSeconds % 60;
    if (!Provider.of<BoardController>(context, listen: false).isSolving)
      checkUser();
  }

  Future<void> checkUser() async {
    await DeviceID().get_token().then((value) async {
      if (await FirestoreScore().checkUser(value)) {
        User user = User(id: value, score: widget.score);
        FirestoreScore().updateUser(user);
      } else {
        PuzzleDialog().editUser(
            context: context,
            confirm: (newname) {
              User user = User(id: value, name: newname, score: widget.score);
              FirestoreScore().addUser(user);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      large: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'Congratulations!!',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "puzzle solved in ",
                          style: AppTextStyles.heading16.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16),
                          children: [
                            if (minutes > 0)
                              TextSpan(
                                  text: minutes.toString() + " min",
                                  style: AppTextStyles.heading18.copyWith(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 18)),
                            TextSpan(
                              text: ",",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: seconds.toString() + " sec",
                                style: AppTextStyles.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " by moving ",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: widget.score.moves.toString(),
                                style: AppTextStyles.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " tiles, score is:\n",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                          ])),
                  Text(
                    widget.score.points.toString(),
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 32),
                  ),
                  Text(
                    "points",
                    style: AppTextStyles.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: FirestoreScore().getUsers(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      List<User> players = snapshot.data!.docs
                          .map((e) =>
                              User.fromMap(e.data() as Map<String, dynamic>))
                          .toList();
                      players.sort(
                          (a, b) => a.score.points.compareTo(b.score.points));
                      return Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.2),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              players.length,
                              (index) {
                                User user = players[index];

                                return UserInfor(
                                  user: user,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SDashtar()
            ],
          ),
        ),
      ),
      medium: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'Congratulations!!',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "puzzle solved in ",
                          style: AppTextStyles.heading16.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16),
                          children: [
                            if (minutes > 0)
                              TextSpan(
                                  text: minutes.toString() + " min",
                                  style: AppTextStyles.heading18.copyWith(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 18)),
                            TextSpan(
                              text: ",",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: seconds.toString() + " sec",
                                style: AppTextStyles.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " by moving ",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: widget.score.moves.toString(),
                                style: AppTextStyles.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " tiles, score is:\n",
                              style: AppTextStyles.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                          ])),
                  Text(
                    widget.score.points.toString(),
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 32),
                  ),
                  Text(
                    "points",
                    style: AppTextStyles.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: FirestoreScore().getUsers(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data == null)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      List<User> players = snapshot.data!.docs
                          .map((e) =>
                              User.fromMap(e.data() as Map<String, dynamic>))
                          .toList();
                      players.sort(
                          (a, b) => a.score.points.compareTo(b.score.points));
                      return Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.2),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              players.length,
                              (index) {
                                User user = players[index];

                                return UserInfor(
                                  user: user,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SDashtar()
            ],
          ),
        ),
      ),
      small: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Stack(
          alignment: Alignment.topCenter,
          children: [
            const SDashtar(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  'Congratulations!!',
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 28),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: "puzzle solved in ",
                        style: AppTextStyles.heading16.copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 16),
                        children: [
                          if (minutes > 0)
                            TextSpan(
                                text: minutes.toString() + " min",
                                style: AppTextStyles.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                          TextSpan(
                            text: ",",
                            style: AppTextStyles.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: seconds.toString() + " sec",
                              style: AppTextStyles.heading18.copyWith(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 18)),
                          TextSpan(
                            text: " by moving ",
                            style: AppTextStyles.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: widget.score.moves.toString(),
                              style: AppTextStyles.heading18.copyWith(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 18)),
                          TextSpan(
                            text: " tiles, score is:\n",
                            style: AppTextStyles.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                        ])),
                Text(
                  widget.score.points.toString(),
                  style: AppTextStyles.instructions
                      .copyWith(color: Colors.black, fontSize: 32),
                ),
                Text(
                  "points",
                  style: AppTextStyles.heading16.copyWith(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: FirestoreScore().getUsers(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data == null)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    List<User> players = snapshot.data!.docs
                        .map((e) =>
                            User.fromMap(e.data() as Map<String, dynamic>))
                        .toList();
                    players.sort(
                        (a, b) => a.score.points.compareTo(b.score.points));
                    return Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.2),
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            players.length,
                            (index) {
                              User user = players[index];

                              return UserInfor(
                                user: user,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfor extends StatefulWidget {
  User user;
  UserInfor({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserInfor> createState() => _UserInforState();
}

class _UserInforState extends State<UserInfor> {
  bool isSelected = false;

  void getid() async {
    await DeviceID().get_token().then((value) {
      setState(() {
        isSelected = widget.user.id == value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getid();
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200])
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.user.name ?? "player",
              style: AppTextStyles.heading16.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : null,
                  color: isSelected
                      ? Colors.black.withOpacity(0.7)
                      : Colors.black.withOpacity(0.5),
                  fontSize: 16),
            ),
            Text(
              widget.user.score.points.toString(),
              style: AppTextStyles.heading18
                  .copyWith(color: Colors.black.withOpacity(0.9), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUser extends StatefulWidget {
  Function(String) action;
  EditUser({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  TextEditingController name = TextEditingController(text: "Puzzler 6345");
  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter User Name!',
            style: AppTextStyles.instructions
                .copyWith(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: name,
            onEditingComplete: () {
              widget.action(name.text);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
              labelText: 'Enter your name',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
              hoverColor: Colors.black.withOpacity(0.5),
              focusColor: Colors.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    widget.action(name.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Confirm',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.green, fontSize: 18),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class ResetGameDialog extends StatefulWidget {
  Function() action;
  ResetGameDialog({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  State<ResetGameDialog> createState() => _ResetGameDialogState();
}

class _ResetGameDialogState extends State<ResetGameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Unfinnished Game!!',
            style: AppTextStyles.instructions
                .copyWith(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
                  text: "Are you sure you want to leave this game?",
                  style: AppTextStyles.heading16.copyWith(
                      color: Colors.black.withOpacity(0.5), fontSize: 14),
                  children: [])),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.black, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    widget.action();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'yes!',
                    style: AppTextStyles.instructions
                        .copyWith(color: Colors.redAccent, fontSize: 18),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class SDashtar extends StatefulWidget {
  const SDashtar({Key? key}) : super(key: key);

  @override
  _DashtarState createState() => _DashtarState();
}

class _DashtarState extends State<SDashtar> {
  SMIBool? dance;
  StateMachineController? controller;
  void init(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'birb');

    artboard.addController(controller!);
    dance = controller.findInput<bool>('dance') as SMIBool;
  }

  void dance42seconds() {
    if (dance?.value == false && mounted) {
      setState(() {
        dance?.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          dance?.value = false;
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dance42seconds();
    Timer.periodic(Duration(seconds: 3), (t) {
      dance42seconds();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (mounted && controller != null) controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      small: Transform.translate(
        offset: Offset(0, -MediaQuery.of(context).size.width * 0.5),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: GestureDetector(
            onTap: () {
              dance42seconds();
            },
            child: RiveAnimation.asset(
              'assets/animations/birb.riv',
              onInit: init,
            ),
          ),
        ),
      ),
      medium: Transform.translate(
        offset: Offset(0, -MediaQuery.of(context).size.width * 0.3),
        child: GestureDetector(
          onTap: () {
            dance42seconds();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            child: RiveAnimation.asset(
              'assets/animations/birb.riv',
              onInit: init,
            ),
          ),
        ),
      ),
      large: GestureDetector(
        onTap: () {
          dance42seconds();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.25,
          width: MediaQuery.of(context).size.width * 0.25,
          child: RiveAnimation.asset(
            'assets/animations/birb.riv',
            onInit: init,
          ),
        ),
      ),
    );
  }
}
