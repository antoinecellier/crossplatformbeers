import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/routes/detail/detail.dart';
import 'package:flutter/material.dart';

class DetailRoute extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final Beer beer = ModalRoute.of(context).settings.arguments;
    return Detail(beer: beer);
  }
}
