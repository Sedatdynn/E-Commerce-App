import 'package:flutter/material.dart';

enum ImageEnums { f, e }

extension ImageEnumsExtension on ImageEnums {
  String get toPath => "assets/travel/$name.jpg";
  Image get toImage => Image.asset(toPath);
}
