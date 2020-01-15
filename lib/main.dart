import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:gdg_flutter_meetup/FavouriteScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( // Defaultowy styl przekazywany i ustawiany wszystkim elementom pokrewnym w strukturze drzewa
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WordPair> wordPairs;
  List<WordPair> favouriteWordPairs;

  @override
  void initState() {
    super.initState();

    wordPairs = List.generate(50, (int index) => WordPair.random());
    favouriteWordPairs = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => FavouriteScreen(favouriteWordPairs)
              ));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) =>
            NameSuggestion(wordPairs[index], onChanged: (bool favorited) {
          if (favorited) {
            favouriteWordPairs.add(wordPairs[index]);
          } else {
            favouriteWordPairs.remove(wordPairs[index]);
          }
        }),
        itemCount: wordPairs.length,
      ),
    );
  }
}

class NameSuggestion extends StatefulWidget {
  // Funkcja dodająca nam element do listy ulubionych
  final void Function(bool favorited) onChanged;

  // Wylosowane sugerowane słowo
  final WordPair wordPair;

  // Getter imienia
  String get name => wordPair.asPascalCase;

  // Konstruktor z parametrami
  NameSuggestion(WordPair this.wordPair, {this.onChanged});

  @override
  _NameSuggestionState createState() => _NameSuggestionState();
}

class _NameSuggestionState extends State<NameSuggestion> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      trailing: Icon(
        _isFavourite ? Icons.favorite : Icons.favorite_border,
        color: _isFavourite ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          _isFavourite = !_isFavourite;
          widget.onChanged(_isFavourite);
        });
      },
    );
  }
}
