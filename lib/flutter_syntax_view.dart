library flutter_syntax_view;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/syntax_theme.dart';

///Import Available Syntaxes
import 'package:flutter_syntax_view/syntaxes/dart.dart';
import 'package:flutter_syntax_view/syntaxes/java.dart';
import 'package:flutter_syntax_view/syntaxes/kotlin.dart';
import 'package:flutter_syntax_view/syntaxes/swift.dart';
import 'package:flutter_syntax_view/syntaxes/javascript.dart';

///Export themes class.
export 'package:flutter_syntax_view/syntax_theme.dart';

///Supported Syntaxes Enum
enum Syntax {
  DART,
  JAVA,
  KOTLIN,
  SWIFT,
  JAVASCRIPT

  ///TODO SUPPORT MORE SYNTAXES
}

class SyntaxView extends StatefulWidget {
  SyntaxView(
      {@required this.code,
      @required this.syntax,
      this.syntaxTheme,
      this.withZoom,
      this.withLinesCount});

  final String code;
  final Syntax syntax;
  final bool withZoom;
  final bool withLinesCount;
  final SyntaxTheme syntaxTheme;

  dynamic getSyntax(Syntax syntax) {
    switch (syntax) {
      case Syntax.DART:
        return DartSyntaxHighlighter(this.syntaxTheme);
      case Syntax.JAVA:
        return JavaSyntaxHighlighter(this.syntaxTheme);
      case Syntax.KOTLIN:
        return KotlinSyntaxHighlighter(this.syntaxTheme);
      case Syntax.SWIFT:
        return SwiftSyntaxHighlighter(this.syntaxTheme);
      case Syntax.JAVASCRIPT:
        return JavaScriptSyntaxHighlighter(this.syntaxTheme);
      default:
        return DartSyntaxHighlighter(this.syntaxTheme);
    }
  }

  @override
  State<StatefulWidget> createState() => SyntaxViewState();
}

class SyntaxViewState extends State<SyntaxView> {
  double textScaleFactor = 1.0;

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
              padding: (widget.withLinesCount ?? true)
                  ? EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
                  : EdgeInsets.all(10),
              color:
                  (widget.syntaxTheme ?? SyntaxTheme.dracula()).backgroundColor,
              constraints: BoxConstraints.expand(),
              child: Scrollbar(
                  child: SingleChildScrollView(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: (widget.withLinesCount ?? true)
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      for (int i = 1; i <= numLines; i++)
                                        RichText(
                                            textScaleFactor: textScaleFactor,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontFamily: 'monospace',
                                                    fontSize: 12.0,
                                                    color:
                                                        (widget.syntaxTheme ??
                                                                SyntaxTheme
                                                                    .dracula())
                                                            .linesCountColor),
                                                text: "$i"))
                                    ]),
                                    VerticalDivider(width: 5),
                                    RichText(
                                      textScaleFactor: textScaleFactor,
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 12.0),
                                        children: <TextSpan>[
                                          widget
                                              .getSyntax(widget.syntax)
                                              .format(widget.code)
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : RichText(
                                  textScaleFactor: textScaleFactor,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 12.0),
                                    children: <TextSpan>[
                                      widget
                                          .getSyntax(widget.syntax)
                                          .format(widget.code)
                                    ],
                                  ),
                                ))))),
          (widget.withZoom ?? false)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.zoom_out,
                            color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                                .zoomIconColor),
                        onPressed: () => setState(() {
                              textScaleFactor = max(0.8, textScaleFactor - 0.1);
                            })),
                    IconButton(
                        icon: Icon(Icons.zoom_in,
                            color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                                .zoomIconColor),
                        onPressed: () => setState(() {
                              textScaleFactor <= 4.0
                                  ? textScaleFactor += 0.1
                                  : print(
                                      "Maximun zoomable scale (4.0) has been reached. more zooming can cause a crash.");
                            })),
                  ],
                )
              : null
        ].where((w) => w != null).toList());
  }
}
