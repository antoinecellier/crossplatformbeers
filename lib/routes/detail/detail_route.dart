import 'package:crossplatformbeers/models/beer.dart';
import 'package:flutter/material.dart';

class DetailRoute extends StatelessWidget {
  static const routeName = '/detail';
  final Beer beer;

  DetailRoute({@required this.beer}) : assert(beer != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(beer.name),
      ),
      body: Container(
        color: theme.cardColor,
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Hero(
                    tag: beer.id,
                    child: Image.network(beer.imageURL),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    beer.tagline,
                    style: theme.textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    beer.description,
                    style: theme.textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
