import 'package:flutter/material.dart';

class CircularIconWithImage extends StatelessWidget {
  final String imagePath;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  const CircularIconWithImage({
    super.key,
    required this.imagePath,
    this.radius = 30,
    this.borderColor = Colors.white,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2 + borderWidth * 2,
      height: radius * 2 + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
        ),
      ),
    );
  }
}
