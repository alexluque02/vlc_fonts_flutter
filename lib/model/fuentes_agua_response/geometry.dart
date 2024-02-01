import 'dart:convert';

class Geometry {
  List<dynamic>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  factory Geometry.fromMap(Map<String, dynamic> data) => Geometry(
        coordinates: data['coordinates'] as List<dynamic>?,
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'coordinates': coordinates,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Geometry].
  factory Geometry.fromJson(String data) {
    return Geometry.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Geometry] to a JSON string.
  String toJson() => json.encode(toMap());
}
