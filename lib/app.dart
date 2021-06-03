import 'package:crossplatformbeers/punkapi_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorites.dart';
import 'routes/behavior/beer_route_information_parser.dart';
import 'routes/behavior/beer_router_delegate.dart';

class CrossPlatformBeersApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CrossPlatformBeersAppState();
}

class _CrossPlatformBeersAppState extends State<CrossPlatformBeersApp> {
  BeerRouterDelegate _routerDelegate = BeerRouterDelegate();
  BeerRouteInformationParser _routeInformationParser =
      BeerRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesModel>(
      create: (_) => FavoritesModel(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Cross plateform Flutter App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
      ),
    );
  }
}
