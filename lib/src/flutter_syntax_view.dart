import 'dart:math'; // max()
import 'package:flutter/material.dart';
import 'dart:ui' as ui; // LineMetrics

import 'syntax/index.dart';

class SyntaxView extends StatefulWidget {
  SyntaxView(
      {@required this.code,
      @required this.syntax,
      this.syntaxTheme,
      this.withZoom = true,
      this.withLinesCount = true,
      this.fontSize = 12.0,
      this.expanded = false,
      this.softWrap = true});

  /// Code text
  final String code;

  /// Syntax/Langauge (Dart, C, C++...)
  final Syntax syntax;

  /// Enable/Disable zooming controlls  (default: true)
  final bool withZoom;

  /// Enable/Disable line number in left  (default: true)
  final bool withLinesCount;

  /// Theme of syntax view example SyntaxTheme.dracula()
  final SyntaxTheme syntaxTheme;

  /// Font Size with a default value of 12.0
  final double fontSize;

  /// Expansion which allows the SyntaxView to be used inside a Column or a ListView...  (default: false)
  final bool expanded;

  /// Wrap text Whether the code text should break at soft line breaks.  (default: true)
  final bool softWrap;

  @override
  State<StatefulWidget> createState() => SyntaxViewState();
}

class SyntaxViewState extends State<SyntaxView> {
  @override
  void initState() {
    super.initState();
    _fontSize = widget.fontSize;
  }

  /// Initial font size from user
  double _fontSize;

  /// For Zooming Controls
  static const double MAX_FONT_SCALE_FACTOR = 4.0;
  static const double MIN_FONT_SCALE_FACTOR = 0.8;
  double _fontScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    assert(widget.code != null,
        "Code Content must not be null.\n===| if you are loading a String from assets, make sure you declare it in pubspec.yaml |===");
    assert(widget.syntax != null,
        "Syntax must not be null. select a Syntax by calling Syntax.(Language)");

    final int numLines = '\n'.allMatches(widget.code).length + 1;
    return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(
              padding: widget.withLinesCount
                  ? const EdgeInsets.only(
                      left: 5, top: 10, right: 10, bottom: 10)
                  : const EdgeInsets.all(10),
              color:
                  (widget.syntaxTheme ?? SyntaxTheme.dracula()).backgroundColor,
              constraints: widget.expanded ? BoxConstraints.expand() : null,
              child: widget.withLinesCount
                  ? buildCodeWithLinesCount(numLines)
                  : buildCode()),
          widget.withZoom ? zoomControls() : null
        ].where((w) => w != null).toList());
  }

  /// Guess num lines accourding to widget size instead of \n
  int _guessNumLines() {
    try {
      final span = _formattedText();
      final textPainter =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      textPainter.layout(
          maxWidth: MediaQuery.of(context)
              .size
              .width); // https://github.com/flutter/flutter/issues/49883
      final List<ui.LineMetrics> lines = textPainter.computeLineMetrics();
      return lines.length;
    } catch (e) {
      print("Exception thrown while guessing numLines ${e.toString()}");
      return null;
    }
  }

  Widget buildCodeWithLinesCount([int pnumLines]) {
    // Try guess how many lines there would be with a soft wrap
    int numLines;
    if (widget.softWrap) // Because of the softWrap, lines count get messed up
    {
      numLines = _guessNumLines();
      // Couldn't guess num lines will be in softwrap, now just use the '\n'.allMatches passed in guessNumLines
      numLines ??= pnumLines;
    } else {
      // softwrap not enabled, '\n'.allMatches will do.
      numLines = pnumLines;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(children: <Widget>[
          for (int i = 1; i <= numLines; i++)
            RichText(
                textScaleFactor: _fontScaleFactor,
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: _fontSize,
                      color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                          .linesCountColor),
                  text: "$i",
                ))
        ]),
        VerticalDivider(width: 5),
        Expanded(child: buildCode()),
      ],
    );
  }

  // Code text
  Widget buildCode() {
    if (widget.softWrap) {
      // no scrolling is needed when code is wrapped
      return RichText(
        softWrap: true,
        overflow: TextOverflow.clip,
        textScaleFactor: _fontScaleFactor,
        text: _formattedText(),
      );
    } else {
      // We need to scroll to see hidden code
      return SingleChildScrollView(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RichText(
              softWrap: false,
              textScaleFactor: _fontScaleFactor,
              text: _formattedText(),
            )),
      );
    }
  }

  TextSpan _formattedText() {
    return TextSpan(
      style: TextStyle(fontFamily: 'monospace', fontSize: _fontSize),
      children: <TextSpan>[
        getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
      ],
    );
  }

  Widget zoomControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.zoom_out,
                color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                    .zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      max(MIN_FONT_SCALE_FACTOR, _fontScaleFactor - 0.1);
                })),
        IconButton(
            icon: Icon(Icons.zoom_in,
                color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                    .zoomIconColor),
            onPressed: () => setState(() {
                  _fontScaleFactor =
                      min(MAX_FONT_SCALE_FACTOR, _fontScaleFactor + 0.1);
                })),
      ],
    );
  }
}
