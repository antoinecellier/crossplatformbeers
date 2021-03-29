import 'package:meta/meta.dart';

@immutable
class Beer {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String imageURL;

  Beer(
      {@required this.id,
      @required this.name,
      this.tagline,
      this.description,
      @required this.imageURL})
      : assert(id != null),
        assert(name != null),
        assert(imageURL != null);

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      imageURL: json['image_url'] as String,
    );
  }

  Beer copyWith(
      {int id,
      String name,
      String tagline,
      String description,
      String imageURL}) {
    return Beer(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      imageURL: imageURL ?? this.imageURL,
    );
  }
}
