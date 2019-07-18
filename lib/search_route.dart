import 'package:flutter/material.dart';

import 'package:f_vazhe/api.dart';
import 'package:f_vazhe/word.dart';
import 'package:f_vazhe/word_tile.dart';

class WordSearch extends StatefulWidget {
  const WordSearch();

  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  final searchTextFieldController = TextEditingController();
  final _exactResults = <Word>[];
  final _avaResults = <Word>[];
  final _likeResults = <Word>[];
  final _textResults = <Word>[];
  final bool _isExpanded = false;
  Word _selectedWord;

  @override
  void dispose() {
    searchTextFieldController.dispose();
    super.dispose();
  }

  Future<void> _retrieveSearch(String q, String type) async {
    final api = Api();
    final jsonSearch = await api.getSearch(q, type);
    if (jsonSearch != null) {
      var _wordsTmp = <Word>[];
      for (var result in jsonSearch) {
        final word = Word.fromJson(result);
        _wordsTmp.add(word);
      }
      setState(() {
        if (type == 'exact') {
          _exactResults.clear();
          _exactResults.addAll(_wordsTmp);
        } else if (type == 'ava') {
          _avaResults.clear();
          _avaResults.addAll(_wordsTmp);
        } else if (type == 'like') {
          _likeResults.clear();
          _likeResults.addAll(_wordsTmp);
        } else if (type == 'text') {
          _textResults.clear();
          _textResults.addAll(_wordsTmp);
        }
      });
    }
  }

//  Future<Word> _retrieveWord(String title, String db, int num) async {
//    final api = Api();
//    final jsonWord = await api.getWord(title, db, num);
//    _selectedWord = Word(
//        id: jsonWord['id'],
//        title: jsonWord['title'],
//        titleEn: jsonWord['titleEn'],
//        pron: jsonWord['pron'],
//        text: jsonWord['text'],
//        source: jsonWord['source'],
//        db: jsonWord['db'],
//        num: jsonWord['num']);
//    return _selectedWord;
//  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: searchTextFieldController,
                textAlign: TextAlign.start,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.subhead,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.subhead,
                  labelText: 'واژه',
                  hintText: 'دنبال چه واژه‌ای می‌گردی؟',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
//                onSubmitted: _retrieveSearch(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchResultTile(String _type) {
    var _typeMap = {
      'exact': 'دقیق',
      'ava': 'هم‌آوا',
      'like': 'مشابه',
      'text': 'معانی',
    };
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 128.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).accentColor,
              ),
              child: Text(
                _typeMap[_type],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title.fontSize,
                ),
              ),
            ),
            onTap: () => _retrieveSearch(searchTextFieldController.text, _type),
          ),
          Container(
            child: _searchResults(_type),
          ),
        ],
      ),
    );
  }

  Widget _searchResults(String _type) {
    var _resultsMap = <WordTile>[];
    if (_type == 'exact') {
      _resultsMap = _exactResults.map((word) => WordTile(word: word)).toList();
    } else if (_type == 'ava') {
      _resultsMap = _avaResults.map((word) => WordTile(word: word)).toList();
    } else if (_type == 'like') {
      _resultsMap = _likeResults.map((word) => WordTile(word: word)).toList();
    } else if (_type == 'text') {
      _resultsMap = _textResults.map((word) => WordTile(word: word)).toList();
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: _resultsMap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اف‌واژه'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _searchBar(),
          _searchResultTile('exact'),
          _searchResultTile('ava'),
          _searchResultTile('like'),
          _searchResultTile('text'),
        ],
      ),
    );
  }
}
