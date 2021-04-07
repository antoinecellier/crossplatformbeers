import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/routes/detail/detail.dart';
import 'package:flutter/material.dart';

class DetailRoute extends StatelessWidget {
  static const routeName = '/detail';
  final Beer beer;

  DetailRoute({@required this.beer}) : assert(beer != null);

  @override
  Widget build(BuildContext context) {
    return Detail(beer: beer);
  }
}
