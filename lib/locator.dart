import 'package:get_it/get_it.dart';
import 'package:samim/features/login/data/repository/login_repositoryimpl.dart';
import 'package:samim/features/login/domain/repository/login_repository.dart';
import 'package:samim/features/login/domain/use_cases/get_countries_usecase.dart';
import 'package:samim/features/login/domain/use_cases/login_usecase.dart';

import 'package:samim/features/login/presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/data/data_source/remote/api_provider.dart';
import 'features/login/data/repository/country_repositoryimpl.dart';
import 'features/login/domain/repository/country_repository.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

GetIt locator = GetIt.instance;

setup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<ApiProvider>(ApiProvider());
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  /// repositories
  locator.registerSingleton<UserRepository>(UserRepositoryImpl());
  locator
      .registerSingleton<CountryRepository>(CountryRepositoryImpl(locator()));

  /// use case
  locator.registerSingleton<GetLoginUseCase>(GetLoginUseCase(locator()));
  locator
      .registerSingleton<GetCountriesUseCase>(GetCountriesUseCase(locator()));

  locator.registerSingleton<LoginBloc>(LoginBloc(locator(), locator()));
  locator.registerSingleton<SettingsBloc>(SettingsBloc(locator()));
}
