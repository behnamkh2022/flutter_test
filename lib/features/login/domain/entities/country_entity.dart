import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String? name;
  final String? alpha3Code;
  final String? capital;
  final Map<String, String>? translations;

  const CountryEntity({
    this.name,
    this.alpha3Code,
    this.capital,
    this.translations,
  });
  @override
  List<Object?> get props => [
        name,
        alpha3Code,
        capital,
        translations,
      ];
}
