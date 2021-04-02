import 'package:flutter/material.dart';

class BeerRouterObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    final _screenName = route.settings.name;
    print('>>>>>> Pushed Route is $_screenName');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    final _screenName = route.settings.name;
    print('>>>>>> Popped Route is $_screenName ');
  }
}
