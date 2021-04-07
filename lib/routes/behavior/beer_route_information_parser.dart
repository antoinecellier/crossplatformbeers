import 'package:flutter/material.dart';

import 'beer_route_path.dart';

class BeerRouteInformationParser extends RouteInformationParser<BeerRoutePath> {
  @override
  Future<BeerRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return BeerRoutePath.home();
    }

    // Handle '/beer/:id
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'beer') return BeerRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return BeerRoutePath.unknown();
      return BeerRoutePath.details(id);
    }

    // Handle unknown routes
    return BeerRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(BeerRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/beer/${path.id}');
    }
    return RouteInformation(location: '/');
  }
}
