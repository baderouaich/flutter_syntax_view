import 'package:flutter/material.dart';

import 'package:flutter_syntax_view/flutter_syntax_edit.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      title: "Flutter Syntax View Example",
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _controller = CodeEditingController(
    DartSyntaxHighlighter(SyntaxTheme.dracula()),
  );

  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context)
        .loadString('assets/dart_code.txt')
        .then((codeText) {
      if (mounted)
        setState(() {
          _controller.text = codeText;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 7,
      ),
      body: SyntaxEditableView(
        syntax: Syntax.DART,
        controller: _controller,
        withZoom: true,
        withLinesCount: true,
      ),
    );
  }
}
