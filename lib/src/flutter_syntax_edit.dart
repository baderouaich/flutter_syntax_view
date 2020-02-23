import 'dart:math';

import 'package:flutter/material.dart';

import 'custom_text_field.dart';
import 'editing_controller.dart';
import 'syntaxes/base.dart';
import 'syntaxes/theme.dart';

class SyntaxEditableView extends StatefulWidget {
  SyntaxEditableView({
    @required this.syntax,
    @required this.controller,
    this.syntaxTheme,
    this.withZoom,
    this.withLinesCount,
  });

  final Syntax syntax;
  final SyntaxTheme syntaxTheme;
  final bool withZoom;
  final bool withLinesCount;
  final CodeEditingController controller;

  @override
  _SyntaxEditableViewState createState() => _SyntaxEditableViewState();
}

class _SyntaxEditableViewState extends State<SyntaxEditableView> {
  SyncScrollController _syncScroller;
  ScrollController _lineNumberScrollController = ScrollController();
  ScrollController _editingScrollController = ScrollController();
  double textScaleFactor = 1.0;
  String code;
  @override
  void initState() {
    _syncScroller = SyncScrollController(
        [_lineNumberScrollController, _editingScrollController]);
    code = widget.controller.text;
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  BoxConstraints size;

  @override
  Widget build(BuildContext context) {
    widget.controller.syntax =
        getSyntax(widget.syntax, widget.syntaxTheme ?? SyntaxTheme.dracula());

    assert(code != null,
        "Code Content must not be null.\n===| if you are loading a String from assets, make sure you declare it in pubspec.yaml |===");
    assert(widget.syntax != null,
        "Syntax must not be null. select a Syntax by calling Syntax.(Language)");
    code = widget.controller.text;

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          padding: (widget.withLinesCount ?? true)
              ? EdgeInsets.only(left: 5, top: 10, right: 10, bottom: 10)
              : EdgeInsets.all(10),
          color: (widget.syntaxTheme ?? SyntaxTheme.dracula()).backgroundColor,
          constraints: BoxConstraints.expand(),
          child: (widget.withLinesCount ?? true)
              ? _buildWithLines()
              : _buildCode(),
        ),
        if (widget.withZoom ?? false) _buildZoomControlls(),
      ].where((w) => w != null).toList(),
    );
  }

  int _getLineCount(BuildContext context) {
    if (size == null) {
      return '\n'.allMatches(code).length + 1;
    }

    final span = getSyntax(widget.syntax, widget.syntaxTheme).format(code);
    final tp = TextPainter(
      text: span,
      textDirection: Directionality.of(context),
      maxLines: null,
      textScaleFactor: textScaleFactor,
    );
    tp.layout(maxWidth: size.maxWidth);
    print('Length: ${tp.computeLineMetrics().length}');
    final int numLines = tp.computeLineMetrics().length + 1;
    return numLines;
  }

  Row _buildZoomControlls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.zoom_out,
                color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                    .zoomIconColor),
            onPressed: () {
              if (mounted)
                setState(() {
                  textScaleFactor = max(0.8, textScaleFactor - 0.1);
                });
            }),
        IconButton(
            icon: Icon(Icons.zoom_in,
                color: (widget.syntaxTheme ?? SyntaxTheme.dracula())
                    .zoomIconColor),
            onPressed: () {
              if (mounted)
                setState(() {
                  textScaleFactor <= 4.0
                      ? textScaleFactor += 0.1
                      : print(
                          "Maximun zoomable scale (4.0) has been reached. more zooming can cause a crash.");
                });
            }),
      ],
    );
  }

  Widget _buildCode() {
    widget.controller.syntax.syntaxTheme
        .merge(TextStyle(fontFamily: 'monospace', fontSize: 12.0));
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          _syncScroller.processNotification(
            scrollInfo,
            _editingScrollController,
          );
        },
        child: CustomTextField(
          scrollController: _editingScrollController,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.top,
          textScaleFactor: textScaleFactor,
          controller: widget.controller,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _buildWithLines() {
    final _style = widget.syntaxTheme ?? SyntaxTheme.dracula();
    int numLines = _getLineCount(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            _syncScroller.processNotification(
              scrollInfo,
              _lineNumberScrollController,
            );
          },
          child: SingleChildScrollView(
            controller: _lineNumberScrollController,
            child: Column(children: <Widget>[
              for (int i = 1; i <= numLines; i++)
                RichText(
                    textScaleFactor: textScaleFactor,
                    text: TextSpan(
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            color: _style.linesCountColor),
                        text: "$i"))
            ]),
          ),
        ),
        VerticalDivider(width: 5),
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: LayoutBuilder(
              builder: (context, size) {
                this.size = size;
                return _buildCode();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SyncScrollController {
  List<ScrollController> _registeredScrollControllers =
      new List<ScrollController>();

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController(List<ScrollController> controllers) {
    controllers.forEach((controller) => registerScrollController(controller));
  }

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) => {
              if (!identical(_scrollingController, controller))
                controller..jumpTo(_scrollingController.offset)
            });
        return;
      }
    }
  }
}
