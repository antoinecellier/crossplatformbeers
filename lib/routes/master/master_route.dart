import 'dart:io';

import 'package:crossplatformbeers/repositories/beer_repository.dart';
import 'package:crossplatformbeers/routes/detail/detail_route.dart';
import 'package:flutter/material.dart';

import 'widgets/punkapi_card.dart';

class MasterRoute extends StatelessWidget {
  static const routeName = '/';

  final BeersRepository beersRepository;

  MasterRoute({@required this.beersRepository})
      : assert(beersRepository != null);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final image = Image.asset(
      'assets/images/punkapi.png',
      height: 40,
      width: 30,
      fit: BoxFit.fitHeight,
    );

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: screenSize.width >= 800
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            image,
            const Text(
              'Punk API',
              style: const TextStyle(
                fontFamily: 'Nerko_One',
                fontSize: 40,
              ),
            ),
            image,
          ],
        ),
        backgroundColor: theme.primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: beersRepository.getBeers(itemsPerPage: 80),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final beers = snapshot.data;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500.0,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: 4,
            ),
            itemCount: beers.length,
            itemBuilder: (_, index) {
              return Container(
                child: PunkApiCard(
                  beer: beers[index],
                  onBeerSelected: (selectedBeer) {
                    Navigator.pushNamed(context, DetailRoute.routeName,
                        arguments: selectedBeer);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
