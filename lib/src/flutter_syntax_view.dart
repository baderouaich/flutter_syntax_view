import 'package:flutter/material.dart';
import 'dart:math' as math; // math.max & max

import 'syntax/index.dart';
import 'syntax/base.dart';

/// A read-only code view with syntax highlight.
class SyntaxView extends StatefulWidget {
  SyntaxView({
    required this.code,
    required this.syntax,
    this.font = 'monospace',
    this.syntaxTheme,
    this.withZoom = true,
    this.withLinesCount = true,
    this.fontSize = 12.0,
    this.expanded = false,
    this.selectable = true
  });

  /// Code text
  final String code;

  /// Font for the editor.
  /// Should be a monospace font.
  final String font;

  /// Syntax/Language (Dart, C, C++...)
  final Syntax syntax;

  /// Enable/Disable zooming controls (default: true)
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
  /// For zooming Controls
  static const double MAX_FONT_SCALE_FACTOR = 3.0;
  static const double MIN_FONT_SCALE_FACTOR = 0.5;
  double _fontScaleFactor = 1.0;
  late ScrollController _verticalScrollController;

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd,
                 children: <Widget>[
      Container(
          padding:
            widget.withLinesCount
              ? const EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
              : const EdgeInsets.all(10),
          color: widget.syntaxTheme!.backgroundColor,
          constraints: widget.expanded ? BoxConstraints.expand() : null,
          child: Scrollbar(
              controller: _verticalScrollController,
              child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                        widget.withLinesCount
                          ? buildCodeWithLinesCount() // Syntax view with line number to the left
                          : buildCode() // Syntax view
                  )
              )
          )
      ),
      if (widget.withZoom) zoomControls() // Zoom controls
    ]);
  }

  /// Build code view with line number bar
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
                widget.selectable
                    ? SelectableText.rich(
                        TextSpan(
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: widget.fontSize,
                              color: widget.syntaxTheme!.linesCountColor),
                          text: "$i",
                        ),
                        textScaler: TextScaler.linear(_fontScaleFactor),
                      )
                    : RichText(
                        textScaler: TextScaler.linear(_fontScaleFactor),
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
      ],
    );
  }

  Widget buildCode() {
    if (widget.selectable) {
      return SelectableText.rich(
        TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ),
        textScaler: TextScaler.linear(_fontScaleFactor),
      );
    } else {
      return RichText(
        textScaler: TextScaler.linear(_fontScaleFactor),
        text: TextSpan(
          style: TextStyle(fontFamily: 'monospace', fontSize: widget.fontSize),
          children: <TextSpan>[
            getSyntax(widget.syntax, widget.syntaxTheme).format(widget.code)
          ],
        ),
      );
    }
  }

  /// Create zoom in+out buttons.
  Widget zoomControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Zoom out
        IconButton(
          icon:
            Icon(Icons.zoom_out, color: widget.syntaxTheme!.zoomIconColor),
          onPressed: 
            () => setState(
              () {
                _fontScaleFactor =
                    math.max(MIN_FONT_SCALE_FACTOR, _fontScaleFactor - 0.1);
              }
            )
        ),
        // Zoom in
        IconButton(
          icon: Icon(Icons.zoom_in, color: widget.syntaxTheme!.zoomIconColor),
          onPressed: () => setState(
            () {
              _fontScaleFactor =
                  math.min(MAX_FONT_SCALE_FACTOR, _fontScaleFactor + 0.1);
            }
          )
        ),
      ],
    );
  }
}
