import 'dart:ui';

import 'package:flutter/material.dart';

enum MyAppTheme { dark, light }

class ColorPaletteBase {
  final Color transparent;
  final Color white;
  final Color black;
  final Color textDark;
  final Color blue;
  final Color green;
  final Color mediumGray;

  const ColorPaletteBase.raw({
    required this.transparent,
    required this.white,
    required this.black,
    required this.textDark,
    required this.blue,
    required this.green,
    required this.mediumGray,
  });
}

/// Fonts
///

class ThemeDataFontsBase {
  final TextStyle bodyM;
  final TextStyle bodyS;
  final TextStyle bodyL;

  const ThemeDataFontsBase.raw({
    required this.bodyM,
    required this.bodyS,
    required this.bodyL,
  });
}

class ThemeDataBase {
  final ColorPaletteBase colors;
  final ThemeDataFontsBase fonts;

  const ThemeDataBase._internal({
    required this.colors,
    required this.fonts,
  });
}

class ThemeDataX extends ThemeDataBase {
  const ThemeDataX._internal({
    required ColorPaletteBase colorPalette,
    required ThemeDataFontsBase fonts,
  }) : super._internal(colors: colorPalette, fonts: fonts);

  factory ThemeDataX.light() {
    return _lightInstance;
  }

  factory ThemeDataX.dark() {
    _darkInstance ??= ThemeDataX._internal(
      colorPalette: colorPaletteDark,
      fonts: _lightInstance.fonts,
    );

    return _darkInstance!;
  }

  static ColorPaletteBase colorPaletteLight = const ColorPaletteBase.raw(
    transparent: Color.fromRGBO(0, 0, 0, 0),
    white: Color.fromRGBO(255, 255, 255, 1),
    black: Color.fromRGBO(0, 0, 0, 1),
    textDark: Color.fromRGBO(29, 29, 29, 1),
    blue: Color.fromRGBO(62, 62, 186, 1),
    green: Color.fromRGBO(23, 145, 107, 1),
    mediumGray: Color.fromRGBO(174, 175, 183, 1),
  );

  static ColorPaletteBase colorPaletteDark = const ColorPaletteBase.raw(
    transparent: Color.fromRGBO(0, 0, 0, 0),
    white: Color.fromRGBO(0, 0, 0, 1),
    textDark: Color.fromRGBO(29, 29, 29, 1),
    black: Color.fromRGBO(255, 255, 255, 1),
    blue: Color.fromRGBO(62, 62, 186, 1),
    green: Color.fromRGBO(23, 145, 107, 1),
    mediumGray: Color.fromRGBO(174, 175, 183, 1),
  );

  static ThemeDataX? _darkInstance;

  static final ThemeDataX _lightInstance = ThemeDataX._internal(
    colorPalette: colorPaletteLight,
    fonts: ThemeDataFontsBase.raw(
        bodyL: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: colorPaletteLight.textDark,
            fontFamily: 'GT Walsheim Pro',
            letterSpacing: .38,
            fontFeatures: const [
              FontFeature.slashedZero(),
              // FontFeature.stylisticSet(1)
            ]),
        bodyM: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: colorPaletteLight.textDark,
            fontFamily: 'GT Walsheim Pro',
            letterSpacing: .38,
            fontFeatures: const [
              FontFeature.slashedZero(),
              // FontFeature.stylisticSet(1)
            ]),
        bodyS: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: colorPaletteLight.textDark,
            fontFamily: 'GT Walsheim Pro',
            letterSpacing: .38,
            fontFeatures: const [
              FontFeature.slashedZero(),
              // FontFeature.stylisticSet(1)
            ])),
  );
}

extension ThemeDataExtensions on ThemeData {
  ColorPaletteBase get colors {
    if (brightness == Brightness.dark) return ThemeDataX.dark().colors;

    return ThemeDataX.light().colors;
  }

  ThemeDataFontsBase get fonts {
    if (brightness == Brightness.dark) return ThemeDataX.dark().fonts;

    return ThemeDataX.light().fonts;
  }
}

var themeDataDark = ThemeData.dark();

var themeDataLight = ThemeData.light().copyWith(
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
      backgroundColor: ThemeDataX.light().colors.black,
      iconTheme:
          IconThemeData(color: ThemeDataX.light().colors.black, size: 24),
      titleTextStyle: ThemeDataX.light()
          .fonts
          .bodyL
          .copyWith(color: ThemeDataX.light().colors.white)),
  primaryColorDark: ThemeDataX.light().colors.black,
  primaryColor: ThemeDataX.light().colors.white,
  scaffoldBackgroundColor: ThemeDataX.light().colors.white,
  primaryIconTheme: ThemeData.light()
      .iconTheme
      .copyWith(color: ThemeDataX.light().colors.black, size: 24),
);

class MyAppThemeData {
  final MyAppTheme theme;

  MyAppThemeData(this.theme);

  ThemeData get themeData {
    switch (theme) {
      case MyAppTheme.dark:
        return themeDataDark;
      case MyAppTheme.light:
        return themeDataLight;
    }
  }
}
