import 'package:flutter/material.dart';

import 'syntax/index.dart';

class SyntaxView extends StatefulWidget {
  SyntaxView({
    @required this.code,
    @required this.syntax,
    this.syntaxTheme,
    this.withZoom,
    this.withLinesCount,
    this.fontSize = 12.0,
    this.expanded = false,
  });

  final String code;
  final Syntax syntax;
  final bool withZoom;
  final bool withLinesCount;
  final SyntaxTheme syntaxTheme;
  final double fontSize;
  final bool expanded;

  @override
  State<StatefulWidget> createState() => SyntaxViewState();
}

class SyntaxViewState extends State<SyntaxView> {
  @override
  void initState() {
    super.initState();
    _fontSize = widget.fontSize;
  }

  /// Zoom Controls
  double _fontSize;
  final double _baseFontSize = 12.0;
  double _fontScale = 1.0;
  double _baseFontScale = 1.0;

  @override
  Widget build(BuildContext context) {
    assert(widget.code != null,
        "Code Content must not be null.\n===| if you are loading a String from assets, make sure you declare it in pubspec.yaml |===");
    assert(widget.syntax != null,
        "Syntax must not be null. select a Syntax by calling Syntax.(Language)");

    return GestureDetector(
      onScaleStart: (final ScaleStartDetails scaleStartDetails) {
        /// Dont apply zooming if disabled
        if (!widget.withZoom) {
          return;
        }
        _baseFontScale = _fontScale;
      },
      onScaleUpdate: (final ScaleUpdateDetails scaleUpdateDetails) {
        /// Dont apply zooming if disabled
        if (!widget.withZoom) {
          return;
        }

        /// don't update the UI if the scale didn't change
        if (scaleUpdateDetails.scale == 1.0) {
          return;
        }

        if (mounted) {
          setState(() {
            _fontScale =
                (_baseFontScale * scaleUpdateDetails.scale).clamp(0.5, 6.0);
            _fontSize = _fontScale * _baseFontSize;
          });
        }
      },
      child: Container(
          padding: (widget.withLinesCount ?? true)
              ? EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
              : EdgeInsets.all(10),
          color: (widget.syntaxTheme ?? SyntaxTheme.dracula()).backgroundColor,
          constraints: widget.expanded ? BoxConstraints.expand() : null,
          child: Scrollbar(
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:

                          /// Lines Count in the left with Code view
                          (widget.withLinesCount ?? true)
                              ? _linesCountWidget()
                              :

                              /// Or Only Code view
                              _codeTextWidget())))),
    );
  }

  /// Widgets parts
  Widget _linesCountWidget() {
    final int numLines = (widget.withLinesCount ?? true)
        ? '\n'.allMatches(widget.code).length + 1
        : 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(children: <Widget>[
          for (int i = 1; i <= numLines; i++)
            RichText(
                textScaleFactor: _baseFontScale,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: _fontSize,
                        color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                            .linesCountColor),
                    text: "$i"))
        ]),
        VerticalDivider(width: 5),
        RichText(
          textScaleFactor: _baseFontScale,
          text: TextSpan(
            style: TextStyle(fontFamily: 'monospace', fontSize: _fontSize),
            children: <TextSpan>[
              getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
            ],
          ),
        ),
      ],
    );
  }

  Widget _codeTextWidget() {
    return RichText(
      textScaleFactor: _baseFontScale,
      text: TextSpan(
        style: TextStyle(fontFamily: 'monospace', fontSize: _fontSize),
        children: <TextSpan>[
          getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
        ],
      ),
    );
  }
}
