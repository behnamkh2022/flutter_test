import 'package:samim/core/usecase/use_case.dart';
import 'package:samim/features/login/domain/repository/country_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/country_entity.dart';

class GetCountriesUseCase
    extends UseCase<DataState<List<CountryEntity>>, NoParams> {
  final CountryRepository countryRepository;

  GetCountriesUseCase(this.countryRepository);

  @override
  Future<DataState<List<CountryEntity>>> call(NoParams params) {
    return countryRepository.getCountries();
  }
}
