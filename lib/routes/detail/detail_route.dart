import 'package:crossplatformbeers/models/beer.dart';
import 'package:crossplatformbeers/routes/detail/widgets/image_viewer.dart';
import 'package:crossplatformbeers/routes/master/master_route.dart';
import 'package:crossplatformbeers/widgets/favorite.dart';
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(beer.name),
        actions: [Favorite(id: beer.id.toString())],
      ),
      body: Container(
        color: theme.cardColor,
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, contrains) {
              return Column(
                children: [
                  buildMainPanel(contrains, theme, context),
                  buildDetailList(context, contrains, theme, beer)
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildMainPanel(
      BoxConstraints contrains, ThemeData theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColorLight,
        borderRadius:
            BorderRadiusDirectional.vertical(bottom: Radius.circular(12)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.4),
            offset: const Offset(0.0, 1.0),
            blurRadius: 6.0,
          )
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: contrains.maxWidth > 800 ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Hero(
              tag: beer.id,
              child: ImageViewer(
                beerId: beer.id,
                imageURL: beer.imageURL,
              ),
            ),
          ),
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
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            Text(
                              beer.abv,
                              maxLines: 1,
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
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
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            Text(
                              beer.ibu,
                              maxLines: 1,
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
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
                              style:
                                  Theme.of(context).primaryTextTheme.headline5,
                            ),
                            Text(
                              beer.targetOg,
                              maxLines: 1,
                              style:
                                  Theme.of(context).primaryTextTheme.headline6,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailList(BuildContext context, BoxConstraints contrains,
      ThemeData theme, Beer beer) {
    int even = 0;
    final foodColumn = Column(
        children: beer.foodPairing
            .map((food) => buildSimpleText(context, food, even++ % 2 == 0))
            .toList(growable: false));

    bool isLarge = contrains.maxWidth > 650;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: <Widget>[
          // Basics
          buildHeader(context, "Description"),
          buildSimpleText(context, beer.description, false),
          Flex(
              direction: isLarge ? Axis.horizontal : Axis.vertical,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isLarge
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      buildHeader(context, "Basics"),
                      buildValue(context, "VOLUME", beer.volume, true),
                      buildValue(
                          context, "BOIL VOLUME", beer.boilVolume, false),
                      buildValue(context, "ABV", beer.abv, true),
                      buildValue(context, "Target FG", beer.targetFg, false),
                      buildValue(context, "Target OG", beer.targetOg, true),
                      buildValue(context, "EBC", beer.ebc, false),
                      buildValue(context, "SRM", beer.srm, true),
                      buildValue(context, "PH", beer.ph, false),
                      buildValue(context, "ATTENUATION LEVEL",
                          beer.attenuationLevel, true),
                    ],
                  ),
                ),

                // Food pairing

                Container(
                  width: 300,
                  child: Column(
                    children: [
                      buildHeader(context, "Food pairing"),
                      foodColumn,
                    ],
                  ),
                ),
              ]),

          // Brewer's tips
          buildHeader(context, "BREWER\'S TIPS"),
          buildSimpleText(context, beer.brewersTips, false),
        ],
      ),
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

  Widget buildSimpleText(BuildContext context, String message, bool even) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: even
            ? Theme.of(context).primaryColorLight
            : Theme.of(context).backgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        message,
        style: Theme.of(context).primaryTextTheme.bodyText2,
      ),
    );
  }

  Widget buildValue(
      BuildContext context, String title, String message, bool even) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: even
            ? Theme.of(context).primaryColorLight
            : Theme.of(context).backgroundColor,
      ),
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
