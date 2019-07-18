import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:f_vazhe/api.dart';
import 'package:f_vazhe/word.dart';

class TranslationRoute extends StatefulWidget {
  final Word word;

  const TranslationRoute({
    Key key,
    this.word,
  })  : assert(word != null),
        super(key: key);

  @override
  _TranslationRouteState createState() => _TranslationRouteState();
}

class _TranslationRouteState extends State<TranslationRoute> {
  String _pron;
  String _text;
  bool _retrievedWord = false;

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setDefaults() {
    setState(() {
      _pron = widget.word.pron;
      _text = widget.word.text;
    });
    _retrieveWord(widget.word.title, widget.word.db, widget.word.num);
  }

  Future<void> _retrieveWord(String title, String db, int num) async {
    final api = Api();
    final jsonWord = await api.getWord(title, db, num);

    Word _selectedWord = Word.fromJson(jsonWord);

    setState(() {
      _pron = _selectedWord.pron;
      _text = _selectedWord.text;
    });
  }

  List<Widget> _translationTile() {
    return [
      Row(
        children: <Widget>[
          Text(
            widget.word.title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.title.fontSize,
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Center(
              child: Text(
                widget.word.source,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            child: Text(_pron),
          ),
        ],
      ),
      Container(
        height: 8.0,
        padding: EdgeInsets.all(4.0),
        child: Text(_text),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اف‌واژه'),
        centerTitle: true,
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 64.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _translationTile()),
          ),
        ),
      ),
    );
  }
}
