import 'package:flutter/material.dart';

import 'package:flutter_syntax_view/flutter_syntax_view.dart';

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
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CodeEditingController();

    _controller.text = """
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

""";
  }

  bool _editing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 7,
        actions: <Widget>[
          IconButton(
            icon: Icon(_editing ? Icons.visibility : Icons.edit),
            onPressed: () {
              if (mounted)
                setState(() {
                  _editing = !_editing;
                });
            },
          ),
        ],
      ),
      body: _editing
          ? SyntaxEditableView(
              syntax: Syntax.DART,
              controller: _controller,
              withZoom: true,
              withLinesCount: true,
            )
          : SyntaxView(
              syntax: Syntax.DART,
              code: _controller.text,
              withZoom: true,
              withLinesCount: true,
            ),
    );
  }
}
