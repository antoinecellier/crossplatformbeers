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
            child: LayoutBuilder(builder: (context, contrains) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    buildMainPanel(contrains, theme, context),
                    buildDetailList(context, contrains, beer)
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Flex buildMainPanel(BoxConstraints contrains, ThemeData theme, BuildContext context) {
    return Flex(
                    direction: contrains.maxWidth > 800 ? Axis.horizontal : Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Hero(
                              tag: beer.id,
                              child: Image.network(beer.imageURL),
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
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
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "ABV",
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline5,
                                        ),
                                        Text(
                                          beer.abv,
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "IBU",
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline5,
                                        ),
                                        Text(
                                          beer.ibu,
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline6,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "OG",
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline5,
                                        ),
                                        Text(
                                          beer.targetOg,
                                          maxLines: 1,
                                          style: Theme.of(context).primaryTextTheme.headline6,
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                    ],
                  );
  }

  Widget buildDetailList(BuildContext context, BoxConstraints contrains, Beer beer) {
    final foodWidgets = <Widget>[];
    beer.foodPairing.forEach((food) => foodWidgets.add(buildSimpleText(context, food)));
    final foodColumn = Column(children: foodWidgets);

    bool isLarge = contrains.maxWidth > 520;

    return Column(
      children: <Widget>[
        // Basics

        Flex(
            direction: isLarge ? Axis.horizontal : Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                child: Column(
                  children: [
                    buildHeader(context, "BASICS"),
                    buildValue(context, "VOLUME", beer.volume),
                    buildValue(context, "BOIL VOLUME", beer.boilVolume),
                    buildValue(context, "ABV", beer.abv),
                    buildValue(context, "Target FG", beer.targetFg),
                    buildValue(context, "Target OG", beer.targetOg),
                    buildValue(context, "EBC", beer.ebc),
                    buildValue(context, "SRM", beer.srm),
                    buildValue(context, "PH", beer.ph),
                    buildValue(context, "ATTENUATION LEVEL", beer.attenuationLevel),
                  ],
                ),
              ),

              // Food pairing

              Container(
                  width: 200,
                  child: Column(
                    children: [
                      buildHeader(context, "FOOD PAIRING"),
                      foodColumn,
                    ],
                  ),

              ),
            ]),

        // Brewer's tips
        buildHeader(context, "BREWER\'S TIPS"),
        buildSimpleText(context, beer.brewersTips),
      ],
    );
  }

  Widget buildHeader(BuildContext context, String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.headline5,
      ),
    );
  }

  Widget buildSimpleText(BuildContext context, String message) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        message,
        style: Theme.of(context).primaryTextTheme.bodyText2,
      ),
    );
  }

  Widget buildValue(BuildContext context, String title, String message) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).primaryTextTheme.subtitle1,
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                message,
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
