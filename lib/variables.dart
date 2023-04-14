import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myStyle(double size, Color color) {
  return GoogleFonts.openSans(
    fontSize: size,
    color: color,
  );
}

TextStyle whiteStyle(double size) {
  return GoogleFonts.openSans(
      color: Colors.white, fontSize: size, decoration: TextDecoration.none);
}

TextStyle blackStyle(double size) {
  return GoogleFonts.openSans(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

TextStyle titleStyle(Color color, double size) {
  return GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);
}

TextStyle extraHeavyStyle(Color color, double size) {
  return GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
}

// Color myRed = Color(0xffe8505b);

Color myRed = Color(0xff2D8CFF);

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
