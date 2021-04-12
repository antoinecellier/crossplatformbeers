import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:crossplatformbeers/routes/detail/detail_route.dart';
import 'package:crossplatformbeers/routes/master/master_route.dart';
import 'package:split_view/split_view.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MasterDetail extends StatefulWidget {
  static const routeName = '/';

  final BeersRepository beersRepository;

  MasterDetail({@required this.beersRepository})
      : assert(beersRepository != null);

  @override
  _MasterDetailState createState() => _MasterDetailState();
}

class _MasterDetailState extends State<MasterDetail> {
  Beer selectedBeer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SplitView(
      initialWeight: 0.3,
      view1: MasterRoute(
        beersRepository: widget.beersRepository,
        onTapped: (selectedBeer) {
          setState(() {
            this.selectedBeer = selectedBeer;
          });
        },
      ),
      view2:
          this.selectedBeer != null ? DetailRoute(beer: selectedBeer) : Home(),
      viewMode: SplitViewMode.Horizontal,
      positionLimit: 350,
      gripColor: theme.primaryColor,
      gripSize: 8,
    );
  }
}
