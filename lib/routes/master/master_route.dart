import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:crossplatformbeers/routes/detail/detail.dart';
import 'package:flutter/material.dart';

import 'master.dart';

class MasterRoute extends StatelessWidget {
  static const routeName = '/list';

  final BeersRepository beersRepository;

  MasterRoute({@required this.beersRepository})
      : assert(beersRepository != null);

  @override
  Widget build(BuildContext context) {
    return Master(beersRepository: beersRepository, onSelectItem: (selectedBeer) {
      Navigator.push(context, MaterialPageRoute( builder: (context) => Detail(beer: selectedBeer,)));
    });
  }
}
