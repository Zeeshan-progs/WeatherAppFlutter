import 'package:flutter/material.dart';
import 'Constants.dart';
import 'package:google_fonts/google_fonts.dart';

bool value = false;
void onChanged(bool value) {
  value = !value;
}

AppBar appBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  actions: [
    Switch(
      value: value,
      onChanged: onChanged,
      inactiveTrackColor: Colors.yellow,
    ),
  ],
  title: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '09/03/2021',
        style: GoogleFonts.lato(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 7),
      Row(
        children: [
          Icon(
            Icons.room,
            color: Colors.red,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            'Delhi,',
            style: smallText,
          ),
          Text(
            'India',
            style: smallText.copyWith(color: Colors.grey),
          ),
        ],
      ),
    ],
  ),
);
