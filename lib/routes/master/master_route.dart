import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/punkapi_card.dart';

class MasterRoute extends StatelessWidget {
  static const routeName = '/list';

  final BeersRepository beersRepository;
  final Function onTapped;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  MasterRoute({@required this.beersRepository, @required this.onTapped})
      : assert(beersRepository != null),
        assert(onTapped != null);

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = Image.asset(
      'assets/images/punkapi.png',
      height: 40,
      width: 30,
      fit: BoxFit.fitHeight,
    );

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const Text(
              'Punk API',
              style: const TextStyle(
                fontFamily: 'Nerko_One',
                fontSize: 40,
              ),
            ),
            image,
          ],
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.wait([
          beersRepository.getBeers(itemsPerPage: 80),
          getFavorites(),
        ]),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Beer> beers = snapshot.data[0];
          List<String> favorites = snapshot.data[1];

          return ListView.builder(
            itemCount: beers.length,
            itemBuilder: (_, index) {
              bool isInfavorite = favorites != null
                  ? favorites.indexWhere((favorite) =>
                          favorite == beers[index].id.toString()) >=
                      0
                  : false;
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: PunkApiCard(
                    beer: beers[index],
                    onBeerSelected: onTapped,
                    onAddToFavorite: onAddToFavorite,
                    onRemoveToFavorite: onRemoveToFavorite,
                    isInFavorite: isInfavorite),
              );
            },
          );
        },
      ),
    );
  }
}
