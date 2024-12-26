import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';
import 'index.dart';

class YamlSyntaxHighlighter extends SyntaxBase {
  YamlSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  late String _src;

  late StringScanner _scanner;

  late List<HighlightSpan> _spans;

  List<String> noKeywords = [
    'http',
    'https',
  ];

  @override
  SyntaxTheme? syntaxTheme;

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

      /// "String"
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// 'String'
      if (_scanner.scan(RegExp(r"'(?:[^'\\]|\\.)*'"))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Line comments
      if (_scanner.scan('#')) {
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

      ///version
      if (_scanner.scan(RegExp(r'(\^)?[0-9]*\.[0-9]*\.[0-9]*(\+)?[0-9]*'))) {
        _spans.add(HighlightSpan(
          HighlightType.klass,
          _scanner.lastMatch!.start,
          _scanner.lastMatch!.end,
        ));
        continue;
      }

      /// Punctuation
      if (_scanner.scan(RegExp(r'[\[\]{}().!=<>&\|\?\+\-\*/%\^~;:,""<>@]'))) {
        _spans.add(HighlightSpan(HighlightType.punctuation,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      /// Words
      if (_scanner.scan(RegExp(r'\w+'))) {
        HighlightType type;
        String? word = _scanner.lastMatch![0];
        int wordEndIndex = _scanner.lastMatch!.end;
        if (wordEndIndex + 1 < _src.length &&
            (_src.substring(wordEndIndex, wordEndIndex + 1) == ':' ||
                _src.substring(wordEndIndex, wordEndIndex + 1) == '-') &&
            !noKeywords.contains(word)) {
          type = HighlightType.keyword;
        } else {
          type = HighlightType.punctuation; // Treated as punctuation for now
        }

        _spans.add(HighlightSpan(
            type, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
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
}
