import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesModel extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<String> _favorites = [];

  FavoritesModel() {
    initFavorites();
  }

  UnmodifiableListView<String> get favorites =>
      UnmodifiableListView(_favorites);

  bool isInFavorites(String id) {
    return _favorites.indexWhere((favorite) => favorite == id.toString()) >= 0;
  }

  void initFavorites() async {
    Iterable<String> favorites = await getFavorites();
    addAll(favorites);
  }

  void addAll(List<String> ids) {
    _favorites.addAll(ids);
    notifyListeners();
  }

  void add(String id) {
    _favorites.add(id);
    notifyListeners();
  }

  void remove(String id) {
    _favorites.removeWhere((favorite) => favorite == id);
    notifyListeners();
  }

  Future<List<String>> getFavorites() async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList('favorites');
    return favorites != null && favorites.isNotEmpty ? favorites : [];
  }

  onAddToFavorite(String beerId) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(beerId);
    await prefs.setStringList('favorites', favorites);
    add(beerId);
  }

  onRemoveToFavorite(String beerId) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.removeWhere((favorite) => favorite == beerId);
    await prefs.setStringList('favorites', favorites);
    remove(beerId);
  }
}
