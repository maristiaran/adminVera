import 'package:flutter/material.dart';

class BottomRoundedAppBar extends StatelessWidget {
  final Color color;
  final double height;
  final double elevation;
  final List<Widget> icons;
  final Function(int) onIconPressed;

  const BottomRoundedAppBar({
    super.key,
    required this.color,
    this.height = 60,
    this.elevation = 8.0,
    required this.icons,
    required this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      color: color,
      clipper: BottomAppBarClipper(),
      elevation: elevation,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: icons.asMap().entries.map((entry) {
            int idx = entry.key;
            Widget iconWidget = entry.value;
            return OversizedIcon(
              icon: iconWidget,
              onPressed: () => onIconPressed(idx),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Widget personalizado para crear iconos grandes
class OversizedIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const OversizedIcon({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(
          0, -10), // Ajuste vertical para sobresalir del BottomAppBar
      child: GestureDetector(
        onTap: onPressed,
        child: icon,
      ),
    );
  }
}

// CustomClipper para crear el BottomAppBar con esquinas redondeadas
class BottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double radius = 20.0; // Radio de las esquinas redondeadas

    // Esquinas superiores redondeadas
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Parte inferior del BottomAppBar con notch para el FAB
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
