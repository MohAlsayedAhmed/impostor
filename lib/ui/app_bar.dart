import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar myAppBar(ThemeData theme) => AppBar(
  title: Text(
    'Impostor (L3ba ta3 moh)',
    style: GoogleFonts.alegreyaSans(
      fontSize: 27.5,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  backgroundColor: theme.primaryColor,
);