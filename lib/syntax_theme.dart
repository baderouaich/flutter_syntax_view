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
    this.backgroundColor,
    this.zoomIconColor,
  });

  final TextStyle baseStyle;
  final TextStyle numberStyle;
  final TextStyle commentStyle;
  final TextStyle keywordStyle;
  final TextStyle stringStyle;
  final TextStyle punctuationStyle;
  final TextStyle classStyle;
  final TextStyle constantStyle;
  final Color backgroundColor;
  final Color zoomIconColor;

  static SyntaxTheme standard() {
    return SyntaxTheme(
      backgroundColor: const Color(0xFFFFFFFF),
      baseStyle: const TextStyle(color: const Color(0xFF000000)),
      numberStyle: const TextStyle(color: const Color(0xFF1565C0)),
      commentStyle: const TextStyle(color: const Color(0xFF9E9E9E)),
      keywordStyle: const TextStyle(color: const Color(0xFF9C27B0)),
      stringStyle: const TextStyle(color: const Color(0xFF43A047)),
      punctuationStyle: const TextStyle(color: const Color(0xFF000000)),
      classStyle: const TextStyle(color: const Color(0xFF512DA8)),
      constantStyle: const TextStyle(color: const Color(0xFF795548)),
      zoomIconColor: const Color(0xFF303d49),
    );
  }

  static SyntaxTheme dracula() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF607D8B),
        baseStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        numberStyle: const TextStyle(color: const Color(0xFF6BC1FF)),
        commentStyle: const TextStyle(color: const Color(0xFF9E9E9E)),
        keywordStyle: const TextStyle(color: const Color(0xFFffa959)),
        stringStyle: const TextStyle(color: const Color(0xFF93ffab)),
        punctuationStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        classStyle: const TextStyle(color: const Color(0xFF44ba8b)),
        constantStyle: const TextStyle(color: const Color(0xFF795548)),
        zoomIconColor: const Color(0xFFFFFFFF));
  }

  static SyntaxTheme ayuLight() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFFFAFAFA),
        baseStyle: const TextStyle(color: const Color(0xFF202734)),
        numberStyle: const TextStyle(color: const Color(0xFF42BEDF)),
        commentStyle: const TextStyle(color: const Color(0xFFACB1B7)),
        keywordStyle: const TextStyle(color: const Color(0xFFFE753B)),
        stringStyle: const TextStyle(color: const Color(0xFF65C8E2)),
        punctuationStyle: const TextStyle(color: const Color(0xFFFCA535)),
        classStyle: const TextStyle(color: const Color(0xFFFE772F)),
        constantStyle: const TextStyle(color: const Color(0xFFFD713E)),
        zoomIconColor: const Color(0xFF202734));
  }

  static SyntaxTheme ayuDark() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF202734),
        baseStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        numberStyle: const TextStyle(color: const Color(0xFFDCC76D)),
        commentStyle: const TextStyle(color: const Color(0xFF5C6C79)),
        keywordStyle: const TextStyle(color: const Color(0xFFFFA040)),
        stringStyle: const TextStyle(color: const Color(0xFF87D06C)),
        punctuationStyle: const TextStyle(color: const Color(0xFFFFCC5F)),
        classStyle: const TextStyle(color: const Color(0xFFFE9741)),
        constantStyle: const TextStyle(color: const Color(0xFFF87E6E)),
        zoomIconColor: const Color(0xFFF8F6EB));
  }

  static SyntaxTheme gravityLight() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFFFAFAFA),
        baseStyle: const TextStyle(color: const Color(0xFF202734)),
        numberStyle: const TextStyle(color: const Color(0xFF3D94FC)),
        commentStyle: const TextStyle(color: const Color(0xFF9DA4AF)),
        keywordStyle: const TextStyle(color: const Color(0xFF0053A9)),
        stringStyle: const TextStyle(color: const Color(0xFF4AA95B)),
        punctuationStyle: const TextStyle(color: const Color(0xFFE7614D)),
        classStyle: const TextStyle(color: const Color(0xFFA94295)),
        constantStyle: const TextStyle(color: const Color(0xFFD15849)),
        zoomIconColor: const Color(0xFF0D1429));
  }

  static SyntaxTheme gravityDark() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF202734),
        baseStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        numberStyle: const TextStyle(color: const Color(0xFF68B3BD)),
        commentStyle: const TextStyle(color: const Color(0xFF666562)),
        keywordStyle: const TextStyle(color: const Color(0xFFC8345A)),
        stringStyle: const TextStyle(color: const Color(0xFFECB760)),
        punctuationStyle: const TextStyle(color: const Color(0xFF9CC266)),
        classStyle: const TextStyle(color: const Color(0xFFEA3971)),
        constantStyle: const TextStyle(color: const Color(0xFFB77ADA)),
        zoomIconColor: const Color(0xFFF8F6EB));
  }

  static SyntaxTheme monokaiSublime() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF272822),
        baseStyle: const TextStyle(color: const Color(0xFF7FEC21)),
        numberStyle: const TextStyle(color: const Color(0xFF38C9E6)),
        commentStyle: const TextStyle(color: const Color(0xFF75715E)),
        keywordStyle: const TextStyle(color: const Color(0xFFF92672)),
        stringStyle: const TextStyle(color: const Color(0xFFE6DB74)),
        punctuationStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        classStyle: const TextStyle(color: const Color(0xFFCF2668)),
        constantStyle: const TextStyle(color: const Color(0xFFAE81FF)),
        zoomIconColor: const Color(0xFFF8F6EB));
  }

  static SyntaxTheme obsidian() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF293134),
        baseStyle: const TextStyle(color: const Color(0xFFE8E2B7)),
        numberStyle: const TextStyle(color: const Color(0xFFFFCD22)),
        commentStyle: const TextStyle(color: const Color(0xFF5D7671)),
        keywordStyle: const TextStyle(color: const Color(0xFF3A76CB)),
        stringStyle: const TextStyle(color: const Color(0xFFDE5A2C)),
        punctuationStyle: const TextStyle(color: const Color(0xFFFFFFFF)),
        classStyle: const TextStyle(color: const Color(0xFF93C763)),
        constantStyle: const TextStyle(color: const Color(0xFF294F8B)),
        zoomIconColor: const Color(0xFFF8F6EB));
  }

  static SyntaxTheme oceanSunset() {
    return SyntaxTheme(
        backgroundColor: const Color(0xFF33353B),
        baseStyle: const TextStyle(color: const Color(0xFFEBCB7B)),

        /// main fibonacci...
        numberStyle: const TextStyle(color: const Color(0xFFD08770)),
        commentStyle: const TextStyle(color: const Color(0xFF908995)),
        keywordStyle: const TextStyle(color: const Color(0xFF62AED2)),

        /// return import .. _keyWords
        stringStyle: const TextStyle(color: const Color(0xFFD9C0A5)),

        /// "content"
        punctuationStyle: const TextStyle(color: const Color(0xFFFFFFFF)),

        /// { () ; . ? < > - + * /
        classStyle: const TextStyle(color: const Color(0xFF4C77A2)),

        /// math.PI => PI color
        constantStyle: const TextStyle(color: const Color(0xFF428CB4)),

        /// const
        zoomIconColor: const Color(0xFFF8F6EB));
  }
}
