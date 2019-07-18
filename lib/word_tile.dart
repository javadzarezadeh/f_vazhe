import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:f_vazhe/word.dart';
import 'package:f_vazhe/translation_route.dart';

class WordTile extends StatelessWidget {
  final Word word;

  const WordTile({
    Key key,
    @required this.word,
  })  : assert(word != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = word.text;
    if (text.length > 128) {
      text = text.substring(0, 128);
    }
    return Material(
      child: Container(
        height: 64.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Text(
                    word.title,
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
                        word.source,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TranslationRoute(word: word)));
              },
            ),
            Container(
              height: 8.0,
              padding: EdgeInsets.all(4.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
