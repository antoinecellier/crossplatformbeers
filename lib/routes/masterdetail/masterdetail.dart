import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:crossplatformbeers/routes/detail/detail.dart';
import 'package:crossplatformbeers/routes/master/master_route.dart';
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
    return Row(
      children: <Widget>[
        Container(
            width: 300,
            child: MasterRoute(
              beersRepository: widget.beersRepository,
              onTapped: (selectedBeer) {
                setState(() {
                  this.selectedBeer = selectedBeer;
                });
              },
            )),
        Expanded(
            child:
                this.selectedBeer != null ? Detail(beer: selectedBeer) : Home())
      ],
    );
  }
}
