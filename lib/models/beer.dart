import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

@immutable
class Beer {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String imageURL;
  final String firstBrewed;
  final String abv;
  final String ibu;
  final String targetOg;
  final String targetFg;
  final String ebc;
  final String srm;
  final String volume;
  final String boilVolume;
  final String ph;
  final String attenuationLevel;
  final List<String> foodPairing;
  final String brewersTips;

  Beer(
      {@required this.id,
      @required this.name,
      this.tagline,
      this.description,
      this.imageURL,
      this.firstBrewed,
      this.abv,
      this.ibu,
      this.targetOg,
      this.targetFg,
      this.ebc,
      this.srm,
      this.volume,
      this.boilVolume,
      this.ph,
      this.attenuationLevel,
      this.foodPairing,
      this.brewersTips})
      : assert(id != null),
        assert(name != null),
        assert(imageURL != null);

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      imageURL: toImageUrlOrDefault(json['image_url']),
      firstBrewed: toDateOrDefault(json['first_brewed']),
      abv: "${toStringOrDefault(json['abv'] as num)}%",
      ibu: toStringOrDefault(json['ibu'] as num),
      targetOg: toStringOrDefault(json['target_og'] as num),
      targetFg: toStringOrDefault(json['target_fg'] as num),
      ebc: toStringOrDefault(json['ebc'] as num),
      srm: toStringOrDefault(json['srm'] as num),
      volume: volumeToString(json['volume']),
      boilVolume: volumeToString(json['boil_volume']),
      ph: toStringOrDefault(json['ph'] as num),
      attenuationLevel: toStringOrDefault(json['attenuation_level'] as num),
      foodPairing: (json['food_pairing'] as List)?.map((e) => e as String)?.toList(),
      brewersTips: json['brewers_tips'],
    );
  }

  Beer copyWith({int id, String name, String tagline, String description, String imageURL}) {
    return Beer(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      imageURL: imageURL ?? this.imageURL,
    );
  }
}
String toDateOrDefault(String date) {
  if (date != null) {
    DateFormat dateFormat;
    String formatStr;
    if (date.length == 4) {
      dateFormat = DateFormat.y("en_US");
      formatStr = "yyyy";
    } else {
      dateFormat = DateFormat.yMMMM("en_US");
      formatStr = "MM/yyyy";
    }
    return dateFormat.format(DateFormat(formatStr).parse(date)).toUpperCase();
  }
  return "-";
}

String toImageUrlOrDefault(String imageUrl) {
  return imageUrl ?? "https://images.punkapi.com/v2/keg.png";
}

String toStringOrDefault(num value) {
  if (value != null) {
    return value.toString();
  }
  return "-";
}

String volumeToString(Map<String, dynamic> json) {
  if (json == null)
    return '-';
  return toStringOrDefault(json["value"]) + convertVolumeName(json["unit"]);
}

String convertVolumeName(String unit) {
  switch (unit) {
    case "liters":
      return "L";
    case "litres":
      return "L";
    case "grams":
      return "g";
    case "kilograms":
      return "kg";
    default:
      return unit;
  }
}
typedef SelectedBeer = void Function(Beer beer);
