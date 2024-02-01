import 'dart:convert';

import 'geo_point2d.dart';
import 'geo_shape.dart';

class Result {
  int? objectid;
  String? calle;
  String? codigo;
  String? foto;
  GeoShape? geoShape;
  GeoPoint2d? geoPoint2d;

  Result({
    this.objectid,
    this.calle,
    this.codigo,
    this.foto,
    this.geoShape,
    this.geoPoint2d,
  });

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        objectid: data['objectid'] as int?,
        calle: data['calle'] as String?,
        codigo: data['codigo'] as String?,
        foto: data['foto'] as String?,
        geoShape: data['geo_shape'] == null
            ? null
            : GeoShape.fromMap(data['geo_shape'] as Map<String, dynamic>),
        geoPoint2d: data['geo_point_2d'] == null
            ? null
            : GeoPoint2d.fromMap(data['geo_point_2d'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'objectid': objectid,
        'calle': calle,
        'codigo': codigo,
        'foto': foto,
        'geo_shape': geoShape?.toMap(),
        'geo_point_2d': geoPoint2d?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());
}
