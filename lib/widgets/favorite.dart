import 'package:crossplatformbeers/models/beer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  final String id;

  const Favorite({Key key, @required this.id})
      : assert(id != null),
        super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isInFavorite = false;

  Future<List<String>> getFavorites() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList('favorites');
  }

  onAddToFavorite(String beerId) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(beerId);
    await prefs.setStringList('favorites', favorites);
  }

  onRemoveToFavorite(String beerId) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.removeWhere((favorite) => favorite == beerId);
    await prefs.setStringList('favorites', favorites);
  }

  @override
  void initState() {
    super.initState();
    initIsInFavorite();
  }

  initIsInFavorite() async {
    List<String> favorites = await getFavorites() ?? [];
    setState(() {
      _isInFavorite = favorites != null
          ? favorites
                  .indexWhere((favorite) => favorite == widget.id.toString()) >=
              0
          : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isInFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isInFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        if (_isInFavorite) {
          onRemoveToFavorite(widget.id.toString());
        } else {
          onAddToFavorite(widget.id.toString());
        }
        setState(() {
          _isInFavorite = !_isInFavorite;
        });
      },
    );
  }
}
