import 'package:flutter/material.dart';
import 'index.dart';

/// The base class of all syntax highlighters
abstract class SyntaxBase {
  SyntaxTheme? get syntaxTheme;
  TextSpan format(String src);
  Syntax get type;
}

/// Supported Languages
enum Syntax { C, CPP, DART, JAVA, JAVASCRIPT, KOTLIN, LUA, PYTHON, RUST, SWIFT, YAML }

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

/// Rich text span highlighter
class HighlightSpan {
  HighlightSpan(this.type, this.start, this.end);

  /// Highlight type (number, comment...)
  final HighlightType type;

  /// Starting offset of the token
  final int start;

  /// Ending offset of the token
  final int end;

  /// Extracts token from String src
  String textForSpan(String src) {
    return src.substring(start, end);
  }

  /// Returns the appropriate styling based on current span type
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

/// Returns the appropriate syntax highlighter for a programming language syntax
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
    case Syntax.RUST:
      return RustSyntaxHighlighter(theme);
    case Syntax.LUA:
      return LuaSyntaxHighlighter(theme);
    case Syntax.PYTHON:
      return PythonSyntaxHighlighter(theme);
  }
}
