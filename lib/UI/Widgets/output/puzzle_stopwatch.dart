import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';
import 'package:slidepuzzle/UI/Widgets/output/responsive_widget.dart';

class StopwatchTimer extends StatefulWidget {
  final Stopwatch stopwatch;
  const StopwatchTimer({
    Key? key,
    required this.stopwatch,
  }) : super(key: key);

  @override
  _TimerTimeState createState() => _TimerTimeState();
}

class _TimerTimeState extends State<StopwatchTimer> {
  void callback(Timer timer) {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(milliseconds: 30), callback);
  }

  @override
  Widget build(BuildContext context) {
    int minutes = widget.stopwatch.elapsed.inMinutes % 60;
    int seconds = widget.stopwatch.elapsed.inSeconds % 60;
    int hours = widget.stopwatch.elapsed.inHours % 60;

    return ResponsiveWidget(
        small: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
              style: AppTextStyles.heading18.copyWith(
                  color: AppColors.primary2,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.timer_rounded)
          ],
        ),
        medium: Text(
          "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
          style: AppTextStyles.heading18.copyWith(
              color: AppColors.grey3,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        large: Text(
          "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
          style: AppTextStyles.heading18.copyWith(
              color: AppColors.grey3,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ));
  }
}
