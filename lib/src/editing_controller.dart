import 'package:flutter/material.dart';

import 'syntaxes/index.dart';

class CodeEditingController extends TextEditingController {
  final SyntaxBase syntax;

  CodeEditingController(this.syntax, {String text}) : super(text: text);

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    syntax.syntaxTheme.merge(style);
    return syntax.format(value.text);
  }

  TextSelection get selection => value.selection;

  set selection(TextSelection newSelection) {
    if (newSelection.start > text.length || newSelection.end > text.length)
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('invalid text selection: $newSelection')
      ]);
    value = value.copyWith(selection: newSelection, composing: TextRange.empty);
  }

  void clear() {
    value = TextEditingValue.empty;
  }

  void clearComposing() {
    value = value.copyWith(composing: TextRange.empty);
  }
}
