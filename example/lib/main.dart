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
  String code = """
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.blueGrey[800],
        elevation: 7,
      ),
      body: SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
        withZoom: true,
        withLinesCount: true,
      ),
    );
  }
}
