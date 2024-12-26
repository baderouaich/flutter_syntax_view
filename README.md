# flutter_syntax_view

Flutter Syntax Highlighter

## Usage

```dart
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

  SyntaxView(
      code: code,	// Code text
      syntax: Syntax.DART,	// Language
      syntaxTheme: SyntaxTheme.vscodeDark(),	// Theme
      fontSize: 12.0,	// Font size
      withZoom: true,	// Enable/Disable zoom icon controls
      withLinesCount: true,	// Enable/Disable line number
      expanded: false,	// Enable/Disable container expansion
      selectable: true // Enable/Disable code text selection
    )
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

## Themes

<img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/ayuDark.png"> <img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/ayuLight.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/dracula.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/gravityDark.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/gravityLight.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/monokaiSublime.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/obsidian.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/oceanSunset.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/standard.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/vscodeDark.png"><img width="270" src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/theme_shots/vscodeLight.png">


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
</table>


## Features and bugs

If you face any problems feel free to open an issue at the [issue tracker][tracker]. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.

[tracker]: https://github.com/BaderEddineOuaich/flutter_syntax_view/issues