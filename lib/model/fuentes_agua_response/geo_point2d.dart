import 'dart:convert';

class GeoPoint2d {
  double? lon;
  double? lat;

  GeoPoint2d({this.lon, this.lat});

  factory GeoPoint2d.fromMap(Map<String, dynamic> data) => GeoPoint2d(
        lon: (data['lon'] as num?)?.toDouble(),
        lat: (data['lat'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'lon': lon,
        'lat': lat,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GeoPoint2d].
  factory GeoPoint2d.fromJson(String data) {
    return GeoPoint2d.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GeoPoint2d] to a JSON string.
  String toJson() => json.encode(toMap());
}
