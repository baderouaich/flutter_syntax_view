import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_syntax_view/src/syntaxes/index.dart';
import 'package:string_scanner/string_scanner.dart';

class YamlSyntaxHighlighter extends SyntaxBase {
  YamlSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <_HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  String _src;

  StringScanner _scanner;

  List<_HighlightSpan> _spans;

  List<String> noKeywords = [
    'http',
    'https',
  ];

  @override
  SyntaxTheme syntaxTheme;

  @override
  Syntax get type => Syntax.YAML;

  @override
  TextSpan format(String src) {
    _src = src;
    _scanner = StringScanner(_src);

    if (_generateSpans()) {
      /// Successfully parsed the code
      final List<TextSpan> formattedText = <TextSpan>[];
      int currentPosition = 0;

      for (_HighlightSpan span in _spans) {
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

      return TextSpan(style: syntaxTheme.baseStyle, children: formattedText);
    } else {
      /// Parsing failed, return with only basic formatting
      return TextSpan(style: syntaxTheme.baseStyle, text: src);
    }
  }

  bool _generateSpans() {
    int lastLoopPosition = _scanner.position;

    while (!_scanner.isDone) {
      /// Skip White space
      _scanner.scan(RegExp(r'\s+'));

      /// Raw r"String"
      if (_scanner.scan(RegExp(r'r".*"'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// Raw r'String'
      if (_scanner.scan(RegExp(r"r'.*'"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// Multiline """String"""
      if (_scanner.scan(RegExp(r'"""(?:[^"\\]|\\(.|\n))*"""'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// Multiline '''String'''
      if (_scanner.scan(RegExp(r"'''(?:[^'\\]|\\(.|\n))*'''"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// "String"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// 'String'
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(_HighlightSpan(
            _HighlightType.string, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// Line comments
      if (_scanner.scan('#')) {
        final int startComment = _scanner.lastMatch.start;
        bool eof = false;
        int endComment;
        if (_scanner.scan(RegExp(r'.*'))) {
          endComment = _scanner.lastMatch.end;
        } else {
          eof = true;
          endComment = _src.length;
        }
        _spans.add(_HighlightSpan(_HighlightType.comment, startComment, endComment));

        if (eof) break;

        continue;
      }

      ///version
      if (_scanner.scan(RegExp(r'(\^)?[0-9]*\.[0-9]*\.[0-9]*(\+)?[0-9]*'))) {
        _spans.add(_HighlightSpan(
          _HighlightType.klass,
          _scanner.lastMatch.start,
          _scanner.lastMatch.end,
        ));
        continue;
      }

      /// Punctuation
      if (_scanner.scan(RegExp(r'[\[\]{}().!=<>&\|\?\+\-\*/%\^~;:,""<>@]'))) {
        _spans.add(_HighlightSpan(
            _HighlightType.punctuation, _scanner.lastMatch.start, _scanner.lastMatch.end));
        continue;
      }

      /// Words
      if (_scanner.scan(RegExp(r'\w+'))) {
        _HighlightType type;
        String word = _scanner.lastMatch[0];
        int wordEndIndex = _scanner.lastMatch.end;
        if (wordEndIndex + 1 < _src.length &&
            (_src.substring(wordEndIndex, wordEndIndex + 1) == ':' ||
                _src.substring(wordEndIndex, wordEndIndex + 1) == '-') &&
            !noKeywords.contains(word)) {
          type = _HighlightType.keyword;
        } else {
          type = _HighlightType.commonWord;
        }

        _spans.add(_HighlightSpan(type, _scanner.lastMatch.start, _scanner.lastMatch.end));
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
      if (_spans[i].type == _spans[i + 1].type && _spans[i].end == _spans[i + 1].start) {
        _spans[i] = _HighlightSpan(_spans[i].type, _spans[i].start, _spans[i + 1].end);
        _spans.removeAt(i + 1);
      }
    }
  }
}

class _HighlightSpan {
  _HighlightSpan(this.type, this.start, this.end);

  final _HighlightType type;
  final int start;
  final int end;

  String textForSpan(String src) {
    return src.substring(start, end);
  }

  TextStyle textStyle(SyntaxTheme syntaxTheme) {
    if (type == _HighlightType.number)
      return syntaxTheme.numberStyle;
    else if (type == _HighlightType.comment)
      return syntaxTheme.commentStyle;
    else if (type == _HighlightType.keyword)
      return syntaxTheme.keywordStyle;
    else if (type == _HighlightType.string)
      return syntaxTheme.stringStyle;
    else if (type == _HighlightType.punctuation)
      return syntaxTheme.punctuationStyle;
    else if (type == _HighlightType.klass)
      return syntaxTheme.classStyle;
    else if (type == _HighlightType.constant)
      return syntaxTheme.constantStyle;
    else
      return syntaxTheme.baseStyle;
  }
}

enum _HighlightType {
  number,
  comment,
  keyword,
  string,
  punctuation,
  klass,
  constant,
  commonWord,
}
