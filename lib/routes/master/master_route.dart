import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:flutter/material.dart';

import 'master.dart';

class MasterRoute extends StatelessWidget {
  static const routeName = '/list';

  final BeersRepository beersRepository;
  final Function onTapped;

  MasterRoute({@required this.beersRepository, @required this.onTapped})
      : assert(beersRepository != null),
        assert(onTapped != null);

  @override
  Widget build(BuildContext context) {
    return Master(beersRepository: beersRepository, onSelectItem: onTapped);
  }
}
