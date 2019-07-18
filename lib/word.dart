import 'package:flutter/foundation.dart';

class Word {
  final String id;
  final String title;
  final String titleEn;
  final String pron;
  final String text;
  final String source;
  final String db;
  final int num;

  const Word({
    @required this.id,
    @required this.title,
    @required this.titleEn,
    @required this.pron,
    @required this.text,
    @required this.source,
    @required this.db,
    @required this.num,
  }) : assert(id != null);

  Word.fromJson(Map<String, dynamic> jsonMap)
      : assert(jsonMap['id'] != null),
        id = jsonMap['id'],
        title = jsonMap['title'],
        titleEn = jsonMap['titleEn'],
        pron = jsonMap['pron'],
        text = jsonMap['text'],
        source = jsonMap['source'],
        db = jsonMap['db'],
        num = jsonMap['num'];
}
