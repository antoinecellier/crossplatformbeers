import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'beer_route_path.dart';
import '../detail/detail_route.dart';
import '../master/master_route.dart';
import '../unknown/unknown_route.dart';
import 'beer_router_animation.dart';

class BeerRouterDelegate extends RouterDelegate<BeerRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BeerRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  TransitionDelegate transitionDelegate = kIsWeb
      ? NoAnimationTransitionDelegate()
      : DefaultTransitionDelegate<dynamic>();

  Beer _selectedBeer;
  bool show404 = false;

  BeerRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  BeerRoutePath get currentConfiguration {
    if (show404) {
      return BeerRoutePath.unknown();
    }
    return _selectedBeer == null
        ? BeerRoutePath.home()
        : BeerRoutePath.details(_selectedBeer.id);
  }

  void _handleBeerTapped(Beer beer) {
    _selectedBeer = beer;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
      pages: [
        MaterialPage(
            key: ValueKey(MasterRoute.routeName),
            child: MasterRoute(
              beersRepository: BeersRepository(
                client: http.Client(),
              ),
              onTapped: _handleBeerTapped,
            )),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownRoute())
        else if (_selectedBeer != null)
          MaterialPage(
              key: ValueKey(DetailRoute.routeName),
              child: DetailRoute(beer: _selectedBeer))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBeer to null
        _selectedBeer = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BeerRoutePath path) async {
    if (path.isUnknown) {
      _selectedBeer = null;
      show404 = true;
      return;
    }
    if (path.isDetailsPage) {
      // Trivial check, i know....
      if (path.id < 0 || path.id > 80) {
        show404 = true;
        return;
      }

      var beersRepository = new BeersRepository(
        client: http.Client(),
      );
      var beers = await beersRepository.getBeers();
      _selectedBeer = beers.firstWhere((beer) => beer.id == path.id);
    } else {
      _selectedBeer = null;
    }

    show404 = false;
  }
}
