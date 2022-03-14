import 'package:flutter/material.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';
import 'package:slidepuzzle/UI/Constantes/Textstyles/text_styles.dart';

class HelperText extends StatefulWidget {
  final List<String> text;
  const HelperText({Key? key, required this.text}) : super(key: key);

  @override
  _HelperTextState createState() => _HelperTextState();
}

class _HelperTextState extends State<HelperText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '1',
        style: AppTextStyles.heading18.copyWith(
            color: AppColors.grey3, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
