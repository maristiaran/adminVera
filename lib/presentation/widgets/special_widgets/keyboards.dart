// import 'package:flutter/material.dart';

// class CustomStringKeyboard extends StatelessWidget {
//   final ValueChanged<String> onKeyTap;

//   const CustomStringKeyboard({required this.onKeyTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     const double keyboardWidth = 420;
//     const double keyboardHeight = 320;
//     const int numRows = 3;
//     const int numCols = 10;
//     const double spacing = 10.0;
//     final double buttonWidth =
//         (keyboardWidth - (spacing * (numCols - 1))) / numCols;
//     final double buttonHeight =
//         (keyboardHeight - (spacing * (numRows - 1))) / numRows;
//     final List<String> keys = [
//       'A',
//       'B',
//       'C',
//       'D',
//       'E',
//       'F',
//       'G',
//       'H',
//       'I',
//       'J',
//       'K',
//       'L',
//       'M',
//       'N',
//       'O',
//       'P',
//       'Q',
//       'R',
//       'S',
//       'T',
//       'U',
//       'V',
//       'W',
//       'X',
//       'Y',
//       'Z',
//       "'",
//       "-",
//       ".",
//       "º",
//       "0",
//       "1",
//       "2",
//       "3",
//       "4",
//       "5",
//       "6",
//       "7",
//       "8",
//       "9"
//     ];

//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 10, // Número de columnas
//         childAspectRatio: 1.2, // Relación de aspecto de las teclas
//         mainAxisSpacing: 4,
//         crossAxisSpacing: 4,
//       ),
//       padding: const EdgeInsets.all(8),
//       itemCount: keys.length,
//       itemBuilder: (context, index) {
//         final keyLabel = keys[index];
//         return ElevatedButton(
//           onPressed: () => onKeyTap(keyLabel),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blueGrey[300],
//             fixedSize: Size(buttonWidth, buttonHeight),
//             padding: const EdgeInsets.all(2),
//           ),
//           child: Text(
//             keyLabel,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }
// }

// class CustomNumericKeyboard extends StatelessWidget {
//   final ValueChanged<String> onKeyTap;

//   const CustomNumericKeyboard({required this.onKeyTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     const double keyboardWidth = 320;
//     const double keyboardHeight = 280;
//     const int numRows = 4;
//     const int numCols = 3;
//     const double spacing = 10.0;
//     final double buttonWidth =
//         (keyboardWidth - (spacing * (numCols - 1))) / numCols;
//     final double buttonHeight =
//         (keyboardHeight - (spacing * (numRows - 1))) / numRows;
//     // Lista de teclas: Números del 0 al 9 y el punto decimal
//     final List<String> keys = [
//       '1',
//       '2',
//       '3',
//       '4',
//       '5',
//       '6',
//       '7',
//       '8',
//       '9',
//       '.',
//       '0'
//     ];

//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3, // Tres columnas para un diseño compacto
//         childAspectRatio: 3, // Relación de aspecto de las teclas
//         mainAxisSpacing: 4,
//         crossAxisSpacing: 4,
//       ),
//       padding: const EdgeInsets.all(8),
//       itemCount: keys.length,
//       itemBuilder: (context, index) {
//         final keyLabel = keys[index];
//         return ElevatedButton(
//           onPressed: () => onKeyTap(keyLabel),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blueGrey[300],
//             fixedSize: Size(buttonWidth, buttonHeight),
//             // fixedSize: Size(80, 30),
//             padding: const EdgeInsets.all(3),
//           ),
//           child: Text(
//             keyLabel,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }
// }
