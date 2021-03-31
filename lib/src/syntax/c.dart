import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import 'base.dart';
import 'index.dart';

class CSyntaxHighlighter extends SyntaxBase {
  CSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  @override
  Syntax get type => Syntax.C;

  @override
  SyntaxTheme? syntaxTheme;

  static const List<String> _keywords = const <String>[
    'include',
    'auto',
    'break',
    'case',
    'const',
    'continue',
    'default',
    'do',
    'else',
    'enum',
    'extern',
    'for',
    'goto',
    'if',
    'inline',
    'register',
    'restrict',
    'return',
    'signed',
    'sizeof',
    'static',
    'struct',
    'switch',
    'typedef',
    'union',
    'unsigned',
    'void',
    'volatile',
    'while',
    'NULL',
  ];

  static const List<String> _builtInTypes = const <String>[
    'char',
    'short',
    'int',
    'long',
    'long long',
    'double',
    'float',

    // <stdint.h> stuff
    "intmax_t", "uintmax_t",
    "int8_t", "uint8_t",
    "int16_t", "uint16_t",
    "int32_t", "uint32_t",
    "int64_t", "uint64_t",
    "int_least8_t", "uint_least8_t",
    "int_least16_t", "uint_least16_t",
    "int_least32_t", "uint_least32_t",
    "int_least64_t", "uint_least64_t",
    "int_fast8_t", "uint_fast8_t",
    "int_fast16_t", "uint_fast16_t",
    "int_fast32_t", "uint_fast32_t",
    "int_fast64_t", "uint_fast64_t",
    "intptr_t", "uintptr_t"
  ];

  late String _src;
  late StringScanner _scanner;

  late List<HighlightSpan> _spans;

  TextSpan format(String src) {
    _src = src;
    _scanner = StringScanner(_src);

    if (_generateSpans()) {
      /// Successfully parsed the code
      final List<TextSpan> formattedText = <TextSpan>[];
      int currentPosition = 0;

      for (HighlightSpan span in _spans) {
        if (currentPosition > span.start) continue;
        if (currentPosition != span.start) {
          formattedText.add(
            TextSpan(
              text: _src.substring(currentPosition, span.start),
            ),
          );
        }

        formattedText.add(TextSpan(
          style: span.textStyle(syntaxTheme),
          text: span.textForSpan(_src),
        ));

        currentPosition = span.end;
      }

      if (currentPosition != _src.length)
        formattedText.add(TextSpan(
          text: _src.substring(currentPosition, _src.length),
        ));

      return TextSpan(style: syntaxTheme!.baseStyle, children: formattedText);
    } else {
      /// Parsing failed, return with only basic formatting
      return TextSpan(style: syntaxTheme!.baseStyle, text: src);
    }
  }

  bool _generateSpans() {
    int lastLoopPosition = _scanner.position;

    while (!_scanner.isDone) {
      /// Skip White space
      _scanner.scan(RegExp(r'\s+'));

      /// Block comments
      if (_scanner.scan(RegExp('/\\*+[^*]*\\*+(?:[^/*][^*]*\\*+)*/'))) {
        _spans.add(HighlightSpan(HighlightType.comment,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Line comments
      if (_scanner.scan('//')) {
        final int startComment = _scanner.lastMatch!.start;
        bool eof = false;
        int endComment;
        if (_scanner.scan(RegExp(r'.*'))) {
          endComment = _scanner.lastMatch!.end;
        } else {
          eof = true;
          endComment = _src.length;
        }
        _spans.add(
            HighlightSpan(HighlightType.comment, startComment, endComment));

        if (eof) break;

        continue;
      }

      /// Raw R"String"
      if (_scanner.scan(RegExp(r'R".*"'))) {
        _spans.add(HighlightSpan(HighlightType.string, _scanner.lastMatch!.start,
            _scanner.lastMatch!.end));
        continue;
      }

      /// "String" "value"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(HighlightSpan(HighlightType.string, _scanner.lastMatch!.start,
            _scanner.lastMatch!.end));
        continue;
      }

      /// Double value x.x .x
      if (_scanner.scan(RegExp(r'\d+\.\d+|.\d+'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start,
            _scanner.lastMatch!.end));
        continue;
      }

      /// Float value x.xf .xf
      if (_scanner.scan(RegExp(r'\d+\.\d+f|.\d+f'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start,
            _scanner.lastMatch!.end));
        continue;
      }

      /// Integer value
      if (_scanner.scan(RegExp(r'\d+'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start,
            _scanner.lastMatch!.end));
        continue;
      }

      /// Preprocessor Conditional compilation () #if, #else, #elif, #ifdef, #ifndef and #endif ) and #pragma
      if (_scanner.scan(RegExp(
          r'(#ifdef)|(#ifndef)|(#if)|(#else)|(#elif)|(#endif)|(#pragma)'))) {
        _spans.add(HighlightSpan(HighlightType.keyword,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Punctuation TEST: https://www.regexpal.com/100066
      if (_scanner.scan(RegExp(r'[\[\]{}().!=><#&\|\?\+\-\*/%\^~;:,]'))) {
        _spans.add(HighlightSpan(HighlightType.punctuation,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Meta data
      if (_scanner.scan(RegExp(r'@\w+'))) {
        _spans.add(HighlightSpan(HighlightType.keyword,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Words
      if (_scanner.scan(RegExp(r'\w+'))) {
        HighlightType? type;

        String word = _scanner.lastMatch![0]!;
        if (word.startsWith('_')) word = word.substring(1);

        if (_keywords.contains(word))
          type = HighlightType.keyword;
        else if (_builtInTypes.contains(word))
          type = HighlightType.keyword;
        else if (_firstLetterIsUpperCase(word))
          type = HighlightType.klass;
        else if (word.length >= 2 &&
            word.startsWith('k') &&
            _firstLetterIsUpperCase(word.substring(1)))
          type = HighlightType.constant;

        if (type != null) {
          _spans.add(HighlightSpan(
              type, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        }
      }

      /// Check if this loop did anything
      if (lastLoopPosition == _scanner.position) {
        /// Failed to parse this file, abort gracefully
        return false;
      }
      lastLoopPosition = _scanner.position;
    }

    _simplify();
    return true;
  }

  void _simplify() {
    for (int i = _spans.length - 2; i >= 0; i -= 1) {
      if (_spans[i].type == _spans[i + 1].type &&
          _spans[i].end == _spans[i + 1].start) {
        _spans[i] =
            HighlightSpan(_spans[i].type, _spans[i].start, _spans[i + 1].end);
        _spans.removeAt(i + 1);
      }
    }
  }

  bool _firstLetterIsUpperCase(String str) {
    if (str.isNotEmpty) {
      final String first = str.substring(0, 1);
      return first == first.toUpperCase();
    }
    return false;
  }
}
