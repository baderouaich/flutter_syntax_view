library flutter_syntax_view;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/syntax_theme.dart';

///Import Available Syntaxes
import 'package:flutter_syntax_view/syntaxes/dart.dart';
import 'package:flutter_syntax_view/syntaxes/java.dart';
import 'package:flutter_syntax_view/syntaxes/kotlin.dart';
import 'package:flutter_syntax_view/syntaxes/swift.dart';

///Export classes to include them here. user will have to import the needed classes if you didn't export from here.
export 'package:flutter_syntax_view/syntax_theme.dart';

///Supported Syntaxes Enum
enum Syntax {
  DART,
  JAVA,
  KOTLIN,
  SWIFT

  ///TODO SUPPORT MORE SYNTAXES
}

class SyntaxView extends StatefulWidget {
  SyntaxView({
    @required this.code,
    @required this.syntax,
    @required this.syntaxTheme,
    this.withZoom,
  });

  final String code;
  final Syntax syntax;
  final bool withZoom;
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
    assert(widget.syntaxTheme != null,
        "syntaxTheme must not be null. select a theme by calling SyntaxTheme.(prefered theme)");
    assert(widget.syntax != null,
        "Syntax must not be null. select a Syntax by calling Syntax.(Language)");

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          color: widget.syntaxTheme.backgroundColor,
          constraints: BoxConstraints.expand(),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: RichText(
                  textScaleFactor: textScaleFactor,
                  text: TextSpan(
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                    children: <TextSpan>[
                      widget.getSyntax(widget.syntax).format(widget.code)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        (widget.withZoom ?? false)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.zoom_out,
                          color: widget.syntaxTheme.zoomIconColor),
                      onPressed: () => setState(() {
                            textScaleFactor = max(0.8, textScaleFactor - 0.1);
                          })),
                  IconButton(
                      icon: Icon(Icons.zoom_in,
                          color: widget.syntaxTheme.zoomIconColor),
                      onPressed: () => setState(() {
                            textScaleFactor <= 4.0
                                ? textScaleFactor += 0.1
                                : print(
                                    "Maximun zoomable scale (4.0) has been reached. more zooming can cause a crash.");
                          })),
                ],
              )
            : null
      ].where((child) => child != null).toList(),

      /// To ignore null if zoom is not enabled.
    );
  }
}
