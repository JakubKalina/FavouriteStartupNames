import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  final List<WordPair> wordPairs;

  const FavouriteScreen(this.wordPairs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourites'),
        ),
        body: ListView.builder(
          itemBuilder: (_, int index) => ListTile(
            title: Text(wordPairs[index].asPascalCase),
          ),
          itemCount: wordPairs.length,
        ));
  }
}
