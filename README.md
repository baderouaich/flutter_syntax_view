# flutter_syntax_view

Flutter Syntax Highlighter

## Basic Usage

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String code = """
// Importing core libraries
import 'dart:math';
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}          
final int result = fibonacci(20);
/* and there 
    you have it! */
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SyntaxView(
            code: code, // Code text
            syntax: Syntax.DART, // Language
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 12.0, // Font size
            withZoom: true, // Enable/Disable zoom icon controls
            withLinesCount: true, // Enable/Disable line number
            expanded: false, // Enable/Disable container expansion
            selectable: true // Enable/Disable code text selection
            ),
      ),
    );
  }
}
```

## Create a Custom SyntaxTheme

```dart
class AppColors{

  static const Color backgroundColor = Color(0xff1A1A19);
  static const Color linesCountColor = Color(0xffEFE9D5);
  static const Color commentStyle    = Color(0xffEEDF7A);
  static const Color zoomIconColor   = Color(0xff77CDFF);
  static const Color stringStyle     = Color(0xffF87A53);
  static const Color baseStyle       = Color(0xffF5F5F5);
  static const Color keywordStyle    = Color(0xffCAE0BC);
  static const Color classStyle      = Color(0xffB9E5E8);

}

class HomePage extends StatelessWidget {
   HomePage({super.key});

 static const String code = r"""
import 'dart:math' as math;

// Coffee class is the best!
class Coffee {
  late int _temperature;

  void heat() => _temperature = 100;
  void chill() => _temperature = -5;

  void sip() {
    final bool isTooHot = math.max(37, _temperature) > 37;
    if (isTooHot)
      print("myyy liiips!");
    else
      print("mmmmm refreshing!");
  }

  int? get temperature => temperature;
}
void main() {
  var coffee = Coffee();
  coffee.heat();
  coffee.sip();
  coffee.chill();
  coffee.sip();
}
/* And there
        you have it */""";


  final SyntaxTheme myCustomTheme = SyntaxTheme.standard().copyWith(
    backgroundColor : AppColors.backgroundColor,
    linesCountColor : AppColors.linesCountColor,
    commentStyle    : const TextStyle(color: AppColors.commentStyle),
    zoomIconColor   : AppColors.zoomIconColor,
    stringStyle     :  const TextStyle(color: AppColors.stringStyle),
    baseStyle       : const TextStyle(color: AppColors.baseStyle),
    keywordStyle    :  const TextStyle(color: AppColors.keywordStyle),
    punctuationStyle:  const TextStyle(color: AppColors.keywordStyle),
    classStyle      :  const TextStyle(color: AppColors.classStyle),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SyntaxView(
            code: code, // Code text
            syntax: Syntax.DART, // Language
            syntaxTheme: myCustomTheme, // Theme
            fontSize: 12.0, // Font size
            withZoom: true, // Enable/Disable zoom icon controls
            withLinesCount: true, // Enable/Disable line number
            expanded: false, // Enable/Disable container expansion
            selectable: true // Enable/Disable code text selection
          ),
      ),
    );
  }
}
```

## Supported Syntax

- [x] Dart
- [x] C
- [x] C++
- [x] Java
- [x] Kotlin
- [x] Swift
- [x] JavaScript
- [x] YAML
- [x] Rust
- [x] Lua
- [x] Python

## Themes

<img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/ayuDark.png"> <img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/ayuLight.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/dracula.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/gravityDark.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/gravityLight.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/monokaiSublime.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/obsidian.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/oceanSunset.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/standard.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/vscodeDark.png"><img width="270" src="https://raw.githubusercontent.com/baderouaich/flutter_syntax_view/master/theme_shots/vscodeLight.png">


## Installing

[Package](https://pub.dartlang.org/packages/flutter_syntax_view)


## Contributing

- if you are familiar with Regular Expressions in Dart and would like contribute in adding further syntax support. it will be very appreciated!


## Contributors ✨
Thanks goes to these wonderful people!<br>
<table>
  <tr>
    <a href="https://github.com/rodydavis">
      <img width="50" height="50" src="https://github.com/rodydavis.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/LuodiJackShen">
      <img width="50" height="50" src="https://github.com/LuodiJackShen.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/luodijack">
      <img width="50" height="50" src="https://github.com/luodijack.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/marwenx">
      <img width="50" height="50" src="https://github.com/marwenx.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/shyam1s15">
      <img width="50" height="50" src="https://github.com/shyam1s15.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/jhon2520">
      <img width="50" height="50" src="https://github.com/jhon2520.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/Binozo">
      <img width="50" height="50" src="https://github.com/Binozo.png">
    </a>
  </tr>
  <tr>
    <a href="https://github.com/lebao3105">
      <img width="50" height="50" src="https://github.com/lebao3105.png">
    </a>
  </tr>
</table>


## Features and bugs

If you face any problems feel free to open an issue at the [issue tracker][tracker]. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.

[tracker]: https://github.com/baderouaich/flutter_syntax_view/issues
