import 'dart:convert';

import 'result.dart';

class FuentesAguaResponse {
  int? totalCount;
  List<Result>? results;

  FuentesAguaResponse({this.totalCount, this.results});

  factory FuentesAguaResponse.fromMap(Map<String, dynamic> data) {
    return FuentesAguaResponse(
      totalCount: data['total_count'] as int?,
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => Result.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'total_count': totalCount,
        'results': results?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FuentesAguaResponse].
  factory FuentesAguaResponse.fromJson(String data) {
    return FuentesAguaResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FuentesAguaResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
