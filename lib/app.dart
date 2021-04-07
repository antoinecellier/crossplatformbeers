import 'package:crossplatformbeers/punkapi_theme.dart';
import 'package:flutter/material.dart';

import 'routes/behavior/beer_route_information_parser.dart';
import 'routes/behavior/beer_router_delegate.dart';

class PunkApiApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PunkApiAppState();
}

class _PunkApiAppState extends State<PunkApiApp> {
  BeerRouterDelegate _routerDelegate = BeerRouterDelegate();
  BeerRouteInformationParser _routeInformationParser =
      BeerRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cross plateform Flutter App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
