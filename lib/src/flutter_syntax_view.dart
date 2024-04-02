import 'package:flutter/material.dart';
import 'dart:math' as math; // math.max & max

import 'syntax/index.dart';

class SyntaxView extends StatefulWidget {
  SyntaxView(
      {required this.code,
      required this.syntax,
      this.syntaxTheme,
      this.withZoom = true,
      this.withLinesCount = true,
      this.fontSize = 12.0,
      this.expanded = false,
      this.selectable = true});

  /// Code text
  final String code;

  /// Syntax/Langauge (Dart, C, C++...)
  final Syntax syntax;

  /// Enable/Disable zooming controlls (default: true)
  final bool withZoom;

  /// Enable/Disable line number in left (default: true)
  final bool withLinesCount;

  /// Theme of syntax view example SyntaxTheme.dracula() (default: SyntaxTheme.dracula())
  final SyntaxTheme? syntaxTheme;

  /// Font Size with a default value of 12.0
  final double fontSize;

  /// Expansion which allows the SyntaxView to be used inside a Column or a ListView... (default: false)
  final bool expanded;

  /// selectable allow user to let user select the code
  final bool selectable;

  @override
  State<StatefulWidget> createState() => SyntaxViewState();
}

class SyntaxViewState extends State<SyntaxView> {
  /// For Zooming Controls
  static const double MAX_FONT_SCALE_FACTOR = 3.0;
  static const double MIN_FONT_SCALE_FACTOR = 0.5;
  double _fontScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: <Widget>[
      Container(
          padding: widget.withLinesCount
              ? const EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
              : const EdgeInsets.all(10),
          color: widget.syntaxTheme!.backgroundColor,
          constraints: widget.expanded ? BoxConstraints.expand() : null,
          child: Scrollbar(
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: widget.withLinesCount
                          ? buildCodeWithLinesCount() // Syntax view with line number to the left
                          : buildCode() // Syntax view
                      )))),
      if (widget.withZoom) zoomControls() // Zoom controll icons
    ]);
  }

  Widget buildCodeWithLinesCount() {
    final int numLines = '\n'.allMatches(widget.code).length + 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 1; i <= numLines; i++)
                RichText(
                    textScaleFactor: _fontScaleFactor,
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: widget.fontSize,
                          color: widget.syntaxTheme!.linesCountColor),
                      text: "$i",
                    )),
            ]),
        VerticalDivider(width: 5),
        buildCode(),
        //Expanded(child: buildCode()),
      ],
    );
  }

  // Code text
  /*Widget buildCode() {
    return RichText(
        textScaleFactor: _fontScaleFactor,
        text: /* formatted text */ TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ));
  }*/

  Widget buildCode() {
    if (widget.selectable) {
      return SelectableText.rich(
        /* formatted text */
        TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ),
        textScaleFactor: _fontScaleFactor,
      );
    } else {
      return RichText(
        textScaleFactor: _fontScaleFactor,
        text: /* formatted text */ TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ),
      );
    }
  }

  Widget zoomControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon:
                Icon(Icons.zoom_out, color: widget.syntaxTheme!.zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      math.max(MIN_FONT_SCALE_FACTOR, _fontScaleFactor - 0.1);
                })),
        IconButton(
            icon: Icon(Icons.zoom_in, color: widget.syntaxTheme!.zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      math.min(MAX_FONT_SCALE_FACTOR, _fontScaleFactor + 0.1);
                })),
      ],
    );
  }
}
