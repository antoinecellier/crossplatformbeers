class BeerRoutePath {
  final int id;
  final bool isUnknown;

  BeerRoutePath.home()
      : id = null,
        isUnknown = null;

  BeerRoutePath.details(this.id) : isUnknown = false;

  BeerRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
