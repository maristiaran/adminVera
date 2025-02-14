import 'package:flutter/material.dart';

class PowerButton extends IconButton {
  final String powerName;
  PowerButton(
      {super.key, required this.powerName, super.iconSize, super.onPressed})
      : super(icon: Image.asset("assets/V1/Iconos_Poderes/$powerName.png"));
}
