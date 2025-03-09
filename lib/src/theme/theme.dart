import 'package:flutter/material.dart';

class SyntaxTheme {
  SyntaxTheme({
    this.baseStyle,
    this.numberStyle,
    this.commentStyle,
    this.keywordStyle,
    this.stringStyle,
    this.punctuationStyle,
    this.classStyle,
    this.constantStyle,
    this.linesCountColor,
    this.backgroundColor,
    this.zoomIconColor,
  });

  /// Default style
  TextStyle? baseStyle;

  /// Numbers style
  TextStyle? numberStyle;

  /// Comments style
  TextStyle? commentStyle;

  /// Keywords style, e.g. var, let, const...
  TextStyle? keywordStyle;

  /// Strings style, e.g. "Hello"
  TextStyle? stringStyle;

  /// Punctuation style
  TextStyle? punctuationStyle;

  /// Class names style
  TextStyle? classStyle;

  /// Constants style
  TextStyle? constantStyle;

  /// Lines count to the left color
  Color? linesCountColor;

  /// Background color
  Color? backgroundColor;

  /// Zooming controls color
  Color? zoomIconColor;

  /// Standard Theme
  static SyntaxTheme standard() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 55, 71, 79),
      backgroundColor: const Color(0xFFFFFFFF),
      baseStyle: const TextStyle(color: Color(0xFF000000)),
      numberStyle: const TextStyle(color: Color(0xFF1565C0)),
      commentStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      keywordStyle: const TextStyle(color: Color(0xFF9C27B0)),
      stringStyle: const TextStyle(color: Color(0xFF43A047)),
      punctuationStyle: const TextStyle(color: Color(0xFF000000)),
      classStyle: const TextStyle(color: Color(0xFF512DA8)),
      constantStyle: const TextStyle(color: Color(0xFF795548)),
      zoomIconColor: const Color(0xFF303d49),
    );
  }

  /// Darcula Theme (Here called dracula, only God knows why)
  static SyntaxTheme dracula() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF263238),
      baseStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      numberStyle: const TextStyle(color: Color(0xFF6BC1FF)),
      commentStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      keywordStyle: const TextStyle(color: Color(0xFFffa959)),
      stringStyle: const TextStyle(color: Color(0xFF93ffab)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      classStyle: const TextStyle(color: Color(0xFF44ba8b)),
      constantStyle: const TextStyle(color: Color(0xFF795548)),
      zoomIconColor: const Color(0xFFFFFFFF),
    );
  }

  // Ayu Light Theme
  static SyntaxTheme ayuLight() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 55, 71, 79),
      backgroundColor: const Color(0xFFFAFAFA),
      baseStyle: const TextStyle(color: Color(0xFF202734)),
      numberStyle: const TextStyle(color: Color(0xFF42BEDF)),
      commentStyle: const TextStyle(color: Color(0xFFACB1B7)),
      keywordStyle: const TextStyle(color: Color(0xFFFE753B)),
      stringStyle: const TextStyle(color: Color(0xFF65C8E2)),
      punctuationStyle: const TextStyle(color: Color(0xFFFCA535)),
      classStyle: const TextStyle(color: Color(0xFFFE772F)),
      constantStyle: const TextStyle(color: Color(0xFFFD713E)),
      zoomIconColor: const Color(0xFF202734),
    );
  }

  /// Ayu Dark Theme
  static SyntaxTheme ayuDark() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(204, 255, 255, 255),
      backgroundColor: const Color(0xFF202734),
      baseStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      numberStyle: const TextStyle(color: Color(0xFFDCC76D)),
      commentStyle: const TextStyle(color: Color(0xFF5C6C79)),
      keywordStyle: const TextStyle(color: Color(0xFFFFA040)),
      stringStyle: const TextStyle(color: Color(0xFF87D06C)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFCC5F)),
      classStyle: const TextStyle(color: Color(0xFFFE9741)),
      constantStyle: const TextStyle(color: Color(0xFFF87E6E)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Gravity Light Theme
  static SyntaxTheme gravityLight() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 55, 71, 79),
      backgroundColor: const Color(0xFFFAFAFA),
      baseStyle: const TextStyle(color: Color(0xFF202734)),
      numberStyle: const TextStyle(color: Color(0xFF3D94FC)),
      commentStyle: const TextStyle(color: Color(0xFF9DA4AF)),
      keywordStyle: const TextStyle(color: Color(0xFF0053A9)),
      stringStyle: const TextStyle(color: Color(0xFF4AA95B)),
      punctuationStyle: const TextStyle(color: Color(0xFFE7614D)),
      classStyle: const TextStyle(color: Color(0xFFA94295)),
      constantStyle: const TextStyle(color: Color(0xFFD15849)),
      zoomIconColor: const Color(0xFF0D1429),
    );
  }

  /// Gravity Dark Theme
  static SyntaxTheme gravityDark() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(204, 255, 255, 255),
      backgroundColor: const Color(0xFF202734),
      baseStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      numberStyle: const TextStyle(color: Color(0xFF68B3BD)),
      commentStyle: const TextStyle(color: Color(0xFF666562)),
      keywordStyle: const TextStyle(color: Color(0xFFC8345A)),
      stringStyle: const TextStyle(color: Color(0xFFECB760)),
      punctuationStyle: const TextStyle(color: Color(0xFF9CC266)),
      classStyle: const TextStyle(color: Color(0xFFEA3971)),
      constantStyle: const TextStyle(color: Color(0xFFB77ADA)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Monokai Sublime Theme
  static SyntaxTheme monokaiSublime() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF272822),
      baseStyle: const TextStyle(color: Color(0xFF7FEC21)),
      numberStyle: const TextStyle(color: Color(0xFF38C9E6)),
      commentStyle: const TextStyle(color: Color(0xFF75715E)),
      keywordStyle: const TextStyle(color: Color(0xFFF92672)),
      stringStyle: const TextStyle(color: Color(0xFFE6DB74)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      classStyle: const TextStyle(color: Color(0xFFCF2668)),
      constantStyle: const TextStyle(color: Color(0xFFAE81FF)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Obsidian Theme
  static SyntaxTheme obsidian() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF293134),
      baseStyle: const TextStyle(color: Color(0xFFE8E2B7)),
      numberStyle: const TextStyle(color: Color(0xFFFFCD22)),
      commentStyle: const TextStyle(color: Color(0xFF5D7671)),
      keywordStyle: const TextStyle(color: Color(0xFF3A76CB)),
      stringStyle: const TextStyle(color: Color(0xFFDE5A2C)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      classStyle: const TextStyle(color: Color(0xFF93C763)),
      constantStyle: const TextStyle(color: Color(0xFF294F8B)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Ocean Sunset Theme
  static SyntaxTheme oceanSunset() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF33353B),
      baseStyle: const TextStyle(color: Color(0xFFEBCB7B)),
      numberStyle: const TextStyle(color: Color(0xFFD08770)),
      commentStyle: const TextStyle(color: Color(0xFF908995)),
      keywordStyle: const TextStyle(color: Color(0xFF62AED2)),
      stringStyle: const TextStyle(color: Color(0xFFD9C0A5)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      classStyle: const TextStyle(color: Color(0xFF4C77A2)),
      constantStyle: const TextStyle(color: Color(0xFF428CB4)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Visual Studio Dark Theme
  static SyntaxTheme vscodeDark() {
    return SyntaxTheme(
      linesCountColor: const Color.fromARGB(179, 255, 255, 255),
      backgroundColor: const Color(0xFF1E1E1E),
      baseStyle: const TextStyle(color: Color(0xFFD4D4D4)),
      numberStyle: const TextStyle(color: Color(0xFFB5CEA8)),
      commentStyle: const TextStyle(color: Color(0xFF6A9955)),
      keywordStyle: const TextStyle(color: Color(0xFF569CD6)),
      stringStyle: const TextStyle(color: Color(0xFFD69D85)),
      punctuationStyle: const TextStyle(color: Color(0xFFFFFFFF)),
      classStyle: const TextStyle(color: Color(0xFF4EC9B0)),
      constantStyle: const TextStyle(color: Color(0xFF9CDCFE)),
      zoomIconColor: const Color(0xFFF8F6EB),
    );
  }

  /// Visual Studio Light Theme
  static SyntaxTheme vscodeLight() {
    return SyntaxTheme(
        linesCountColor: Color.fromARGB(179, 0, 0, 0),
        backgroundColor: const Color(0xFFFFFFFF),
        baseStyle: const TextStyle(color: Color(0xFF000000)),
        numberStyle: const TextStyle(color: Color(0xFF098658)),
        commentStyle: const TextStyle(color: Color(0xFF008000)),
        keywordStyle: const TextStyle(color: Color(0xFF0000FF)),
        stringStyle: const TextStyle(color: Color(0xFFA31515)),
        punctuationStyle: const TextStyle(color: Color(0xFF000000)),
        classStyle: const TextStyle(color: Color(0xFF267f99)),
        constantStyle: const TextStyle(color: Color(0xFF0070C1)),
        zoomIconColor: const Color(0xFF0D1429));
  }

  SyntaxTheme copyWith({
    TextStyle? baseStyle,
    TextStyle? numberStyle,
    TextStyle? commentStyle,
    TextStyle? keywordStyle,
    TextStyle? stringStyle,
    TextStyle? punctuationStyle,
    TextStyle? classStyle,
    TextStyle? constantStyle,
    Color? linesCountColor,
    Color? backgroundColor,
    Color? zoomIconColor,
  }) {
    return SyntaxTheme(
      baseStyle: baseStyle ?? this.baseStyle,
      numberStyle: numberStyle ?? this.numberStyle,
      commentStyle: commentStyle ?? this.commentStyle,
      keywordStyle: keywordStyle ?? this.keywordStyle,
      stringStyle: stringStyle ?? this.stringStyle,
      punctuationStyle: punctuationStyle ?? this.punctuationStyle,
      classStyle: classStyle ?? this.classStyle,
      constantStyle: constantStyle ?? this.constantStyle,
      linesCountColor: linesCountColor ?? this.linesCountColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      zoomIconColor: zoomIconColor ?? this.zoomIconColor,
    );
  }
}
