import 'package:flutter/material.dart';

import 'editing_controller.dart';
import 'syntaxes/base.dart';

class SyntaxEditableView extends StatefulWidget {
  SyntaxEditableView({
    @required this.syntax,
    @required this.controller,
    this.withZoom,
    this.withLinesCount,
  });

  final Syntax syntax;
  final bool withZoom;
  final bool withLinesCount;
  final CodeEditingController controller;

  @override
  State<StatefulWidget> createState() => SyntaxEditableViewState();
}

class SyntaxEditableViewState extends State<SyntaxEditableView> {
  double textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
