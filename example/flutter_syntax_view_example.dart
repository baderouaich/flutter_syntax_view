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
  String code = "";
  @override
  void initState() {
    super.initState();

    // Loading code text from assets/dart_code.txt
    // Use DefaultAssetBundle. Recommended ( it allows switching asset bundles at runtime ).
    DefaultAssetBundle.of(context)
        .loadString('assets/dart_code.txt')
        .then((codeText) {
      setState(() {
        code = codeText ?? "null";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Syntax View Example"),
        backgroundColor: Colors.deepOrange[300],
        elevation: 7,
      ),
      body: SyntaxView(
        code: code,
        withZoom: true,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
      ),
    );
  }
}
