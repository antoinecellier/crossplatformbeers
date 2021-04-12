import 'package:crossplatformbeers/models/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  final String id;

  const Favorite({Key key, @required this.id})
      : assert(id != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesModel = context.watch<FavoritesModel>();
    bool isInFavorite = favoritesModel.isInFavorites(id.toString());
    return IconButton(
      icon: Icon(
        isInFavorite ? Icons.favorite : Icons.favorite_border,
        color: isInFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        if (isInFavorite) {
          favoritesModel.onRemoveToFavorite(id.toString());
        } else {
          favoritesModel.onAddToFavorite(id.toString());
        }
      },
    );
  }
}
