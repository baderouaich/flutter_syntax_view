import 'package:flutter/src/painting/text_span.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:string_scanner/string_scanner.dart';

class JsonSyntaxHighLighter extends SyntaxBase{

  @override
  SyntaxTheme? syntaxTheme;

  late List<HighlightSpan> _spans;

  late String _src;

  late StringScanner _scanner;

  @override
  Syntax get type => Syntax.JSON;

  JsonSyntaxHighLighter([this.syntaxTheme]){
    _spans = <HighlightSpan>[];
    syntaxTheme = SyntaxTheme.dracula();
  }




  @override
  TextSpan format(String src) {

    _src = src;
    _scanner = StringScanner(_src);

    if(!_generateSpans()){
      return TextSpan(style: syntaxTheme!.baseStyle, text: src);
    }

    final List<TextSpan> formattedText = [];
    int currentPosition = 0;

    for (HighlightSpan span in _spans) {
      if(currentPosition > span.start){
        continue;
      }
      if(currentPosition != span.start){
        formattedText.add(
          TextSpan(text: _src.substring(currentPosition, span.start))
        );
      }
      
    }



    throw UnimplementedError();
  }


  bool _generateSpans(){

    int positionInLopp = _scanner.position;
    while (!_scanner.isDone) {
      if(_scanner.scan(RegExp(r"""['"]"""))){
        _spans.add(HighlightSpan(HighlightType.string,
          _scanner.lastMatch!.start, _scanner.lastMatch!.end
        ));
      }
    }

    if(positionInLopp == _scanner.position){return false;}

    return true;
  
  }


}