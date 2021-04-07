import 'package:crossplatformbeers/models/beer.dart';
import 'package:flutter/material.dart';

class PunkApiCard extends StatefulWidget {
  final Beer beer;
  final SelectedBeer onBeerSelected;
  final AddBeerToFavorite onAddToFavorite;
  final OnRemoveToFavorite onRemoveToFavorite;
  final bool isInFavorite;

  const PunkApiCard(
      {Key key,
      @required this.beer,
      this.onBeerSelected,
      this.onAddToFavorite,
      this.onRemoveToFavorite,
      this.isInFavorite})
      : assert(beer != null),
        super(key: key);

  @override
  _PunkApiCardState createState() => _PunkApiCardState();
}

class _PunkApiCardState extends State<PunkApiCard> {
  static const gestureDetectorKey = Key('gestureDetectorKey');

  bool _isInFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isInFavorite = widget.isInFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      key: gestureDetectorKey,
      onTap: () {
        if (widget.onBeerSelected != null) {
          widget.onBeerSelected(widget.beer);
        }
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.4),
              offset: const Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Hero(
                tag: widget.beer.id,
                child: Image.network(
                  widget.beer.imageURL,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.beer.name,
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      widget.beer.tagline,
                      style: theme.textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _isInFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isInFavorite ? Colors.red : Colors.black,
              ),
              onPressed: () {
                if (_isInFavorite) {
                  widget.onRemoveToFavorite(widget.beer.id.toString());
                } else {
                  widget.onAddToFavorite(widget.beer.id.toString());
                }
                setState(() {
                  _isInFavorite = !_isInFavorite;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
