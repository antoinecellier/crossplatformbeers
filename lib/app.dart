import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/punkapi_theme.dart';
import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:crossplatformbeers/routes/detail/detail_route.dart';
import 'package:crossplatformbeers/routes/master/master_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'routes/behavior/beer_route_information_parser.dart';
import 'routes/behavior/beer_router_delegate.dart';
import 'routes/behavior/beer_router_observer.dart';

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
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
