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
  static final String code = """
// Importing core libraries
import 'dart:math';
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}          
var result = fibonacci(20);
/* and there 
    you have it! */
""";

  static final syntaxViews = {
    "Standard": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.standard(),
        withZoom: true,
        withLinesCount: true),
    "Dracula": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
        withZoom: true,
        withLinesCount: true),
    "AyuLight": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.ayuLight(),
        withZoom: true,
        withLinesCount: true),
    "AyuDark": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.ayuDark(),
        withZoom: true,
        withLinesCount: true),
    "GravityLight": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.gravityLight(),
        withZoom: true,
        withLinesCount: true),
    "GravityDark": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.gravityDark(),
        withZoom: true,
        withLinesCount: true),
    "MonokaiSublime": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.monokaiSublime(),
        withZoom: true,
        withLinesCount: true),
    "Obsidian": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.obsidian(),
        withZoom: true,
        withLinesCount: true),
    "OceanSunset": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.oceanSunset(),
        withZoom: true,
        withLinesCount: true),
    "vscodeDark": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeDark(),
        withZoom: true,
        withLinesCount: true),
    "vscodeLight": SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.vscodeLight(),
        withZoom: true,
        withLinesCount: true)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 7,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: syntaxViews.length,
          itemBuilder: (BuildContext context, int index) {
            String themeName = syntaxViews.keys.elementAt(index);
            SyntaxView syntaxView = syntaxViews.values.elementAt(index);
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 6.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.brush_sharp),
                        Text(
                          themeName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.brush_sharp),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: syntaxView)
                ],
              ),
            );
          }),
    );
  }
}
