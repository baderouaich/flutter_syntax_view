import 'package:flutter/material.dart';

import 'syntaxes/index.dart';

class CodeEditingController extends TextEditingController {
  SyntaxBase syntax;

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    return getTextSpan(value.text);
  }

  TextSpan getTextSpan(String source) {
    return getSyntax(syntax.type, syntax.syntaxTheme).format(source);
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
