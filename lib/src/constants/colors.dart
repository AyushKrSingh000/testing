import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

// const primaryColor = Color.fromARGB(105, 229, 204, 141);
//

const primaryColor = Colors.amber;
const scaffoldColor = Color(0XFFeeeeee);
const appBarColor = Colors.black;
const profitColor = Color(0xFF22b237);
const lossColor = Color(0xFFE50914);
const bottomNavBarColor = Color(0xFF121212);
const systemLightNavColor = Color(0xFFf3f3f3);
final pdfBackgroundColor = PdfColor.fromHex('#fdf8f0');
final pdfTextColor = PdfColor.fromHex('#453638');

// Gradients
const enabledButtonGradient = LinearGradient(
  colors: [Color(0xFFA51EEB), Color(0xFF5822B4)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
