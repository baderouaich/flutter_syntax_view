# flutter_syntax_view
A SyntaxView Widget which highlights code text according to the programming language syntax.

## Usage

```dart
// Load code text from assets/your_code.txt
// Use DefaultAssetBundle. Recommended ( it allows switching asset bundles at runtime ).

String code = "";
DefaultAssetBundle.of(context).loadString('assets/your_code.txt').then((codeText) {
  setState(() {
    code = codeText;
  });
});
SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
        withZoom: true,
       );
```

## Supported Syntax

- [x] Dart
- More will be added.


## Themes
<p align="center">
  <img src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/SyntaxThemes.png" title="ScreenShots">
</p>

## TODO

- [ ] Add More Syntax Support.
- [ ] Add More Themes.


## Installing
[Package](https://pub.dartlang.org/packages/flutter_syntax_view)



## Features and bugs

If you face any problems feel free to open an issue at the [issue tracker][tracker]. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.

[tracker]: https://github.com/BaderEddineOuaich/flutter_syntax_view/issues

