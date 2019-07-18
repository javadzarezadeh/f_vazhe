import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

import 'search_route.dart';

void main() {
  runApp(FVazhe());
}

class FVazhe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
      ],
      locale: Locale("fa", "IR"),
      theme: ThemeData(
        primaryColor: Colors.purple[900],
        accentColor: Colors.greenAccent[200],
        textSelectionHandleColor: Colors.greenAccent[200],
        cursorColor: Colors.greenAccent[200],
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0,
              color: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Colors.purple[900],
                  ),
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Colors.purple[900],
                  ),
            ),
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: Colors.black,
            ),
      ),
      title: 'اف-واژه',
      home: WordSearch(),
    );
  }
}
