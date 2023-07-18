import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:samim/features/login/data/data_source/remote/api_provider.dart';
import 'package:samim/features/login/data/models/country_model.dart';
import 'package:samim/features/login/domain/repository/country_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entities/country_entity.dart';

class CountryRepositoryImpl extends CountryRepository {
  ApiProvider apiProvider;

  CountryRepositoryImpl(this.apiProvider);

  @override
  Future<DataState<List<CountryEntity>>> getCountries() async {
    try {
      Response response = await apiProvider.getCountries();
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.data);
        List<CountryEntity> countries =
            data.map((json) => CountryModel.fromJson(json)).toList();
        return DataSuccess(countries);
      } else {
        return const DataFailed("Something Went Wrong. try again...");
      }
    } catch (e) {
      return const DataFailed("please check your connection...");
    }
  }
}
