import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color color1 = Colors.blue;
Color color2 = Colors.purple;
Color color3 = Colors.lightBlue;
var baseTheme = ThemeData();

class PresentationSettings {
  double topBarHeight = 70.0;
  double bottomBarHeight = 40.0;
  static final PresentationSettings _singleton =
      PresentationSettings._internal();

  factory PresentationSettings() {
    return _singleton;
  }
  PresentationSettings._internal();
}

ThemeData defaultTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme:

// GoogleFonts.latoTextTheme(baseTheme.textTheme),

          TextTheme(
        //   displaySmall: const TextStyle(
        //       fontFamily: 'AmaticSC',
        //       color: Colors.black,
        //       fontSize: 16,
        //       fontStyle: FontStyle.normal,
        //       fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.newsreader(
            color: Colors.blueGrey, fontSize: 26, fontWeight: FontWeight.w500),
        titleMedium: GoogleFonts.newsreader(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        titleSmall: GoogleFonts.leagueSpartan(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),

        // displayMedium: TextStyle(
        //     fontFamily: 'AmaticSC',
        //     color: color1,
        //     fontSize: 28,
        //     fontStyle: FontStyle.normal,
        //     fontWeight: FontWeight.bold),

        // titleLarge: TextStyle(
        //     fontFamily: 'AmaticSC',
        //     color: color2,
        //     fontSize: 42,
        //     fontStyle: FontStyle.normal,
        //     fontWeight: FontWeight.bold),
      ),
      // const ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //         textStyle: WidgetStatePropertyAll(TextStyle(
      //             color: Colors.yellow,
      //             fontSize: 36,
      //             fontWeight: FontWeight.w700,
      //             fontFamily: 'AmaticSC')),
      //         backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      //         overlayColor: WidgetStatePropertyAll(Colors.transparent),
      //         surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
      //         shadowColor: WidgetStatePropertyAll(Colors.transparent),
      //         foregroundColor: WidgetStatePropertyAll(Colors.blue)))
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.blueAccent.shade700; // Darker shade on press
            }
            return Colors.blueAccent; // Normal background color
          }),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevation: WidgetStateProperty.all(5.0),
        ),
      ),
    );
