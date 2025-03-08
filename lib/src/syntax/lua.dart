import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import 'index.dart';

class LuaSyntaxHighlighter extends SyntaxBase {
  LuaSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  @override
  Syntax get type => Syntax.LUA;

  @override
  SyntaxTheme? syntaxTheme;

  static const List<String> _keywords = <String>[
    'and',
    'break',
    'do',
    'else',
    'elseif',
    'end',
    'false',
    'for',
    'function',
    'if',
    'in',
    'local',
    'nil',
    'not',
    'or',
    'repeat',
    'return',
    'then',
    'true',
    'until',
    'while',
  ];

  static const List<String> _builtInFunctions = <String>[
    'assert',
    'collectgarbage',
    'dofile',
    'error',
    'getmetatable',
    'ipairs',
    'load',
    'loadfile',
    'next',
    'pairs',
    'pcall',
    'print',
    'rawequal',
    'rawget',
    'rawlen',
    'rawset',
    'require',
    'select',
    'setmetatable',
    'tonumber',
    'tostring',
    'type',
    'xpcall',
  ];

  late String _src;
  late StringScanner _scanner;
  late List<HighlightSpan> _spans;

  @override
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

      if (currentPosition != _src.length) {
        formattedText.add(TextSpan(
          text: _src.substring(currentPosition, _src.length),
        ));
      }
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
      if (_scanner.scan(RegExp(r'--\[(=*)\[[\s\S]*?\]\1\]'))) {
        _spans.add(HighlightSpan(HighlightType.comment, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Line comments
      if (_scanner.scan(RegExp(r'--(?!\[)[^\n]*'))) {
        _spans.add(HighlightSpan(HighlightType.comment, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// String literals
      if (_scanner.scan(RegExp(r'\[(=*)\[[\s\S]*?\]\1\]'))) {
        _spans.add(HighlightSpan(HighlightType.string, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Double quote Strings
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(HighlightSpan(HighlightType.string, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Single quote Strings
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(HighlightSpan(HighlightType.string, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Numbers
      if (_scanner.scan(RegExp(r'\d+\.\d+([eE][+-]?\d+)?'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }
      if (_scanner.scan(RegExp(r'\.\d+([eE][+-]?\d+)?'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }
      if (_scanner.scan(RegExp(r'\d+([eE][+-]?\d+)?'))) {
        _spans.add(HighlightSpan(HighlightType.number, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Operators
      if (_scanner.scan(RegExp(r'[\[\]{}().,;:+\-*/%^#<>~=]'))) {
        _spans.add(HighlightSpan(HighlightType.punctuation, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Identifiers
      if (_scanner.scan(RegExp(r'\w+'))) {
        HighlightType? type;
        String word = _scanner.lastMatch![0]!;
        if (_keywords.contains(word)) {
          type = HighlightType.keyword;
        } else if (_builtInFunctions.contains(word)) {
          type = HighlightType.keyword;
        }
        if (type != null) {
          _spans.add(HighlightSpan(type, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        }
        continue;
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
    for (int i = _spans.length - 2; i >= 0; i--) {
      if (_spans[i].type == _spans[i + 1].type && _spans[i].end == _spans[i + 1].start) {
        _spans[i] = HighlightSpan(_spans[i].type, _spans[i].start, _spans[i + 1].end);
        _spans.removeAt(i + 1);
      }
    }
  }
}
