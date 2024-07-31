import 'package:flutter/material.dart';
import 'index.dart';

abstract class SyntaxBase {
  SyntaxTheme? get syntaxTheme;
  TextSpan format(String src);
  Syntax get type;
}

/// Supported Syntaxes Enum
enum Syntax { C, CPP, DART, JAVA, JAVASCRIPT, KOTLIN, PYTHON, SWIFT, YAML }

/// Tokens
enum HighlightType {
  number,
  comment,
  keyword,
  string,
  punctuation,
  klass, // or struct
  constant
}

class HighlightSpan {
  HighlightSpan(this.type, this.start, this.end);
  final HighlightType type;
  final int start;
  final int end;

  String textForSpan(String src) {
    return src.substring(start, end);
  }

  TextStyle? textStyle(SyntaxTheme? syntaxTheme) {
    switch (type) {
      case HighlightType.number:
        return syntaxTheme!.numberStyle;

      case HighlightType.comment:
        return syntaxTheme!.commentStyle;

      case HighlightType.keyword:
        return syntaxTheme!.keywordStyle;

      case HighlightType.string:
        return syntaxTheme!.stringStyle;

      case HighlightType.punctuation:
        return syntaxTheme!.punctuationStyle;

      case HighlightType.klass:
        return syntaxTheme!.classStyle;

      case HighlightType.constant:
        return syntaxTheme!.constantStyle;

      default:
        return syntaxTheme!.baseStyle;
    }
  }
}

SyntaxBase getSyntax(Syntax syntax, SyntaxTheme? theme) {
  switch (syntax) {
    case Syntax.DART:
      return DartSyntaxHighlighter(theme);
    case Syntax.C:
      return CSyntaxHighlighter(theme);
    case Syntax.CPP:
      return CPPSyntaxHighlighter(theme);
    case Syntax.JAVA:
      return JavaSyntaxHighlighter(theme);
    case Syntax.KOTLIN:
      return KotlinSyntaxHighlighter(theme);
    case Syntax.SWIFT:
      return SwiftSyntaxHighlighter(theme);
    case Syntax.JAVASCRIPT:
      return JavaScriptSyntaxHighlighter(theme);
    case Syntax.YAML:
      return YamlSyntaxHighlighter(theme);
    default:
      return DartSyntaxHighlighter(theme);
  }
}
