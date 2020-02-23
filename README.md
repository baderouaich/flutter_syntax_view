# flutter_syntax_view

A SyntaxView Widget which highlights code text according to the programming language syntax using Native Dart code.

## Usage

```dart
// Load code text from your assets path.
// Use DefaultAssetBundle. Recommended ( it allows switching asset bundles at runtime ).

String code = "";
DefaultAssetBundle.of(context)
    .loadString('assets/dart_code.txt')
    .then((codeText) => setState(() => code = codeText));
SyntaxView(
        code: code,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
        withZoom: true,
        withLinesCount: true,
      );
```

## Supported Syntax

- [x] Dart
- [x] Java
- [x] Kotlin
- [x] Swift
- [x] JavaScript
- More will be added.

## Themes

<p align="center">
  <img src="https://raw.githubusercontent.com/BaderEddineOuaich/flutter_syntax_view/master/SyntaxThemes.png" title="ScreenShots">
</p>

## TODO

- [ ] Add More Syntax Support.
- [ ] Add More Themes.

## Contributing

- if you are familiar with Regular Expressions in Dart and would like contribute in adding further syntax support. it will be very appreciated!

## Contributors

- Bader Eddine Ouaich <badereddineouaich@gmail.com>
- Rody Davis Jr <rody.davis.jr@gmail.com>

## Installing

[Package](https://pub.dartlang.org/packages/flutter_syntax_view)

## Features and bugs

If you face any problems feel free to open an issue at the [issue tracker][tracker]. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.

[tracker]: https://github.com/BaderEddineOuaich/flutter_syntax_view/issues
