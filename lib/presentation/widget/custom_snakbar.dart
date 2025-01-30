import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar kSnakbar({required String text, Color col = Colors.grey}) {
  return SnackBar(
    duration: const Duration(milliseconds: 1400),
    content: Text(text,
        style: GoogleFonts.mukta(textStyle: const TextStyle(fontSize: 17))),
    behavior: SnackBarBehavior.floating,
    backgroundColor: col,
  );
}