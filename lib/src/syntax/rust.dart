import 'package:flutter/material.dart';
import 'package:string_scanner/string_scanner.dart';
import 'index.dart';

class RustSyntaxHighlighter extends SyntaxBase {
  RustSyntaxHighlighter([this.syntaxTheme]) {
    _spans = <HighlightSpan>[];
    syntaxTheme ??= SyntaxTheme.dracula();
  }

  @override
  Syntax get type => Syntax.RUST;

  @override
  SyntaxTheme? syntaxTheme;

  /// List of Rust keywords for syntax highlighting
  static const List<String> _keywords = <String>[
    'as',
    'async',
    'await',
    'break',
    'const',
    'continue',
    'crate',
    'dyn',
    'else',
    'enum',
    'extern',
    'false',
    'fn',
    'for',
    'if',
    'impl',
    'in',
    'let',
    'loop',
    'match',
    'mod',
    'move',
    'mut',
    'pub',
    'ref',
    'return',
    'self',
    'Self',
    'static',
    'struct',
    'super',
    'trait',
    'true',
    'type',
    'unsafe',
    'use',
    'where',
    'while',
    'abstract',
    'final',
    'override',
    'macro',
    'try',
    'union',
    'yield',
    'macro_rules'
  ];

  /// List of Rust built-in types
  static const List<String> _builtInTypes = <String>[
    'i8',
    'u8',
    'i16',
    'u16',
    'i32',
    'u32',
    'i64',
    'u64',
    'i128',
    'u128',
    'isize',
    'usize',
    'f32',
    'f64',
    'bool',
    'char',
    'str'
  ];

  /// Source code to be highlighted
  late String _src;

  /// Scanner to tokenize input
  late StringScanner _scanner;

  /// Stores highlighted spans
  late List<HighlightSpan> _spans;

  /// Formats the input source code into a styled [TextSpan]
  TextSpan format(String src) {
    _src = src;
    _scanner = StringScanner(_src);

    if (_generateSpans()) {
      // If parsing is successful, create styled spans
      final List<TextSpan> formattedText = <TextSpan>[];
      int currentPosition = 0;

      for (HighlightSpan span in _spans) {
        // Add plain text before the current span
        if (currentPosition != span.start) {
          formattedText.add(TextSpan(
            text: _src.substring(currentPosition, span.start),
          ));
        }

        // Add the highlighted span
        formattedText.add(TextSpan(
          style: span.textStyle(syntaxTheme),
          text: span.textForSpan(_src),
        ));

        currentPosition = span.end;
      }

      // Add any remaining text after the last span
      if (currentPosition != _src.length) {
        formattedText.add(TextSpan(
          text: _src.substring(currentPosition),
        ));
      }

      // Return a [TextSpan] with all styled spans
      return TextSpan(style: syntaxTheme!.baseStyle, children: formattedText);
    } else {
      // If parsing fails, return plain text
      return TextSpan(style: syntaxTheme!.baseStyle, text: src);
    }
  }

  /// Tokenizes the source code and generates spans for highlighting
  bool _generateSpans() {
    int lastLoopPosition = _scanner.position;

    while (!_scanner.isDone) {
      _scanner.scan(RegExp(r'\s+')); // Skip whitespace

      // Handle single-line comments (e.g., `// comment`)
      if (_scanner.scan('//')) {
        final start = _scanner.lastMatch!.start;
        _scanner.scan(RegExp(r'.*')); // Capture the rest of the line
        _spans.add(
            HighlightSpan(HighlightType.comment, start, _scanner.position));
        continue;
      }

      // Handle raw strings (e.g., `r#"raw string"#`)
      if (_scanner.scan(RegExp(r'r#"(.*?)"#', dotAll: true))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      // Handle regular strings (e.g., `"string"`)
      if (_scanner.scan(RegExp(r'"(?:[^"\\]|\\.)*"'))) {
        _spans.add(HighlightSpan(HighlightType.string,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      // Handle numbers (e.g., integers, floats, binary, hex, octal)
      if (_scanner.scan(RegExp(
          r'\b0b[01_]+\b|\b0o[0-7_]+\b|\b0x[\da-fA-F_]+\b|\b\d+(_\d+)*(\.\d+)?\b'))) {
        _spans.add(HighlightSpan(HighlightType.number,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      // Handle attributes (e.g., `#[attribute]`)
      if (_scanner.scan(RegExp(r'#\[.*?\]', dotAll: true))) {
        _spans.add(HighlightSpan(HighlightType.keyword,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      // Handle punctuation (e.g., `{`, `}`, `;`, etc.)
      if (_scanner.scan(RegExp(r'[()\[\]{}:;.,<>/*&|~!=+\-@$%^?]'))) {
        _spans.add(HighlightSpan(HighlightType.punctuation,
            _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        continue;
      }

      // Handle words (keywords, types, and class names)
      if (_scanner.scan(RegExp(r'\b\w+\b'))) {
        final word = _scanner.lastMatch![0]!;
        HighlightType? type;

        // Determine the type of the word
        if (_keywords.contains(word)) {
          type = HighlightType.keyword; // Highlight as a keyword
        } else if (_builtInTypes.contains(word)) {
          type = HighlightType.keyword; // Highlight as a type
        } else if (word.startsWith('r#')) {
          type =
              HighlightType.string; // Highlight raw strings starting with `r#`
        } else if (_firstLetterIsUpperCase(word)) {
          type = HighlightType.klass; // Highlight class names
        }

        // Add the span if a type is determined
        if (type != null) {
          _spans.add(HighlightSpan(
              type, _scanner.lastMatch!.start, _scanner.lastMatch!.end));
        }
        continue;
      }

      // If no match is found, exit to avoid infinite loop
      if (lastLoopPosition == _scanner.position) {
        return false; // Parsing failed
      }
      lastLoopPosition = _scanner.position;
    }

    _simplify();
    return true;
  }

  /// Simplifies spans by merging adjacent ones of the same type
  void _simplify() {
    for (int i = _spans.length - 2; i >= 0; i--) {
      if (_spans[i].type == _spans[i + 1].type &&
          _spans[i].end == _spans[i + 1].start) {
        // Merge the spans
        _spans[i] =
            HighlightSpan(_spans[i].type, _spans[i].start, _spans[i + 1].end);
        _spans.removeAt(i + 1); // Remove the redundant span
      }
    }
  }

  /// Helper function to check if the first letter of a word is uppercase
  bool _firstLetterIsUpperCase(String str) {
    return str.isNotEmpty && str[0].toUpperCase() == str[0];
  }
}
