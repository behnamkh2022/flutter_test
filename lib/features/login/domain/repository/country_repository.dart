import 'package:samim/features/login/domain/entities/country_entity.dart';

import '../../../../core/resources/data_state.dart';

abstract class CountryRepository {
  Future<DataState<List<CountryEntity>>> getCountries();
}
