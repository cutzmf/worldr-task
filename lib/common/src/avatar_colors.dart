import 'package:flutter/material.dart';

const _avatarColors = [
  Colors.deepPurple,
  Colors.amber,
  Colors.green,
  Colors.indigo,
  Colors.red,
];

Color avatarColorFromString(String value) => avatarColorFromInt(value.hashCode);

Color avatarColorFromInt(int value) =>
    _avatarColors[value % _avatarColors.length];
