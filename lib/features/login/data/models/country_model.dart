import 'package:samim/features/login/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    String? name,
    String? alpha3Code,
    String? capital,
    Map<String, String>? translations,
  }) : super(
          name: name,
          alpha3Code: alpha3Code,
          capital: capital,
          translations: translations,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    Map<String, String> translationsMap =
        Map<String, String>.from(json['translations']);

    return CountryModel(
      name: json['name'] as String,
      alpha3Code: json['alpha3Code'] as String,
      capital: json['capital'] as String,
      translations: translationsMap,
    );
  }
}
