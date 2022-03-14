import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slidepuzzle/UI/Constantes/Colors/colors.dart';

class AppTextStyles {
  static TextStyle heading18 = GoogleFonts.rowdies(
    color: AppColors.primary3,
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static TextStyle heading16 = GoogleFonts.montserrat(
    color: AppColors.primary3,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle button16 = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle button14 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle button12 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static TextStyle appbarDisabled = GoogleFonts.rowdies(
    color: AppColors.grey2,
    fontSize: 22,
    fontWeight: FontWeight.w200,
  );

  static TextStyle appbarEnabled = GoogleFonts.rowdies(
    color: AppColors.primary2,
    fontSize: 22,
    fontWeight: FontWeight.w200,
  );

  static TextStyle instructions = GoogleFonts.rowdies(
    color: AppColors.grey1,
    fontSize: 40,
    fontWeight: FontWeight.w300,
  );
}
