import 'package:example/snippets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      title: "Flutter Syntax View Example",
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // The number is the number of
  // the language in Syntax.values
  int selected_language = 0;

  // Whether to expand the view or not
  bool expandView = true;

  String get code {
    switch (selected_language) {
      case 0:
        return CCode;
      case 1:
        return CPPCode;
      case 2:
        return DartCode;
      case 3:
        return JavaCode;
      case 4:
        return JSCode;
      case 5:
        return KotlinCode;
      case 6:
        return LuaCode;
      case 7:
        return PythonCode;
      case 8:
        return RustCode;
      case 9:
        return SwiftCode;
      case 10:
        return YAMLCode;
      default:
        throw Exception("Index out of bound");
    }
  }

  Map<String, SyntaxView> get syntaxViews => {
    "Standard": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.standard(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
      expanded: expandView,
      selectable: true,
    ),
    "Dracula": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.dracula(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: false,
      expanded: expandView,
      selectable: true,
    ),
    "Ayu Light": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.ayuLight(),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: true,
      expanded: expandView,
    ),
    "Custom AyuLight": SyntaxView(
      code: code,
      syntax: Syntax.DART,
      syntaxTheme: SyntaxTheme.ayuLight().copyWith(
      linesCountColor: Colors.teal,
      keywordStyle: const TextStyle(color: Colors.purple)),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: true,
      expanded: true,
    ),
    "Ayu Dark": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.ayuDark(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: false,
      expanded: expandView,
    ),
    "Gravity Light": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.gravityLight(),
      fontSize: 12.0,
      withZoom: true,
      withLinesCount: true,
      expanded: expandView,
    ),
    "Gravity Dark": SyntaxView(
        code: code,
        syntax: Syntax.values[selected_language],
        syntaxTheme: SyntaxTheme.gravityDark(),
        fontSize: 12.0,
        withZoom: false,
        withLinesCount: false,
        expanded: expandView,
        selectable: true),
    "Monokai Sublime": SyntaxView(
        code: code,
        syntax: Syntax.values[selected_language],
        syntaxTheme: SyntaxTheme.monokaiSublime(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: expandView,
        selectable: true),
    "Obsidian": SyntaxView(
        code: code,
        syntax: Syntax.values[selected_language],
        syntaxTheme: SyntaxTheme.obsidian(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: expandView,
        selectable: true),
    "Ocean Sunset": SyntaxView(
      code: code,
      syntax: Syntax.values[selected_language],
      syntaxTheme: SyntaxTheme.oceanSunset(),
      fontSize: 12.0,
      withZoom: false,
      withLinesCount: true,
      expanded: expandView,
      selectable: true,
    ),
    "VS Code Dark": SyntaxView(
        code: code,
        syntax: Syntax.values[selected_language],
        syntaxTheme: SyntaxTheme.vscodeDark(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: expandView,
        selectable: true),
    "VS Code Light": SyntaxView(
        code: code,
        syntax: Syntax.values[selected_language],
        syntaxTheme: SyntaxTheme.vscodeLight(),
        fontSize: 12.0,
        withZoom: true,
        withLinesCount: true,
        expanded: expandView,
        selectable: true)
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: syntaxViews.keys.length,
      child:
        Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Syntax View Example"),
            elevation: 6,
            bottom: TabBar(
                isScrollable: true,
                tabs:
                  syntaxViews.keys.map(
                    (e) => Tab(text: e)
                  ).toList(),
              ),
            actions: [
              Switch(
                onChanged: (value) => setState(() { expandView = value; }),
                value: expandView
              ),
              Text("Expand view"),
              DropdownMenu<int>(
                initialSelection: selected_language,
                dropdownMenuEntries: Syntax.values.map(
                  (e) => DropdownMenuEntry(
                    value: Syntax.values.indexOf(e),
                    label: capitalize(e.toString().replaceAll(RegExp('Syntax.'), ''))
                  )
                ).toList(),
                onSelected: (idx) => setState(() {
                  selected_language = (idx ?? 0);
                })
              ),
              Spacer()
            ]
          ),
          body: TabBarView(
                children: syntaxViews.values.map(
                  (e) => Row(
                      children: [
                        if (e.expanded)
                          Expanded(child: e)
                        else
                          e
                      ]
                    )
                ).toList()
              )
        )
    );
  }

  String capitalize(String original) => original[0].toUpperCase() + original.substring(1).toLowerCase();
}
