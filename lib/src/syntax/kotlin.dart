import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';

import 'index.dart';
import 'base.dart';

class KotlinSyntaxHighlighter extends SyntaxBase {
  KotlinSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  @override
  Syntax get type => Syntax.KOTLIN;

  @override
  SyntaxTheme? syntaxTheme;

  static const List<String> _keywords = const <String>[
    'as',
    'as?',
    'break',
    'class',
    'yield',
    'continue',
    'do',
    'else',
    'false',
    'for',
    'fun',
    'if',
    'in',
    '!in',
    'interface',
    'is',
    '!is',
    'null',
    'object',
    'package',
    'return',
    'super',
    'this',
    'throw',
    'true',
    'try',
    'typealias',
    'val',
    'var',
    'when',
    'while',
    'by',
    'catch',
    'constructor',
    'delegrate',
    'dynamic',
    'field',
    'file',
    'finally',
    'get',
    'import',
    'init',
    'param',
    'property',
    'receiver',
    'set',
    'setparam',
    'where',
    'actual',
    'abstract',
    'annotation',
    'companion',
    'const',
    'crossinline',
    'data',
    'enum',
    'except',
    'external',
    'final',
    'infix',
    'inline',
    'inner',
    'internal',
    'lateinit',
    'noinline',
    'open',
    'operator',
    'out',
    'override',
    'private',
    'protected',
    'public',
    'reified',
    'sealed',
    'suspend',
    'tailrec',
    'vararg'
  ];

  static const List<String> _builtInTypes = const <String>[
    'Byte',
    'Short',
    'Int',
    'Long',
    'Float',
    'Double',
    'Boolean',
    'Char'
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
        if (currentPosition != span.start)
          formattedText
              .add(TextSpan(text: _src.substring(currentPosition, span.start)));

        formattedText.add(TextSpan(
            style: span.textStyle(syntaxTheme), text: span.textForSpan(_src)));

        currentPosition = span.end;
      }

      if (currentPosition != _src.length)
        formattedText
            .add(TextSpan(text: _src.substring(currentPosition, _src.length)));

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

      /// Raw r"String"
      if (_scanner.scan(RegExp(r'r".*"'))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Raw r'String'
      if (_scanner.scan(RegExp(r"r'.*'"))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Multiline """String"""
      if (_scanner.scan(RegExp(r'"""(?:[^"\\]|\\(.|\n))*"""'))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Multiline '''String'''
      if (_scanner.scan(RegExp(r"'''(?:[^'\\]|\\(.|\n))*'''"))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// "String" "value"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// 'String' 'value'
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Double value
      if (_scanner.scan(RegExp(r'\d+\.\d+'))) {
        _spans.add(HighlightSpan(HighlightType.number,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Integer value
      if (_scanner.scan(RegExp(r'\d+'))) {
        _spans.add(HighlightSpan(HighlightType.number,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Punctuation
      if (_scanner.scan(RegExp(r'[\[\]{}().!=<>&\|\?\+\-\*/%\^~;:,]'))) {
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
