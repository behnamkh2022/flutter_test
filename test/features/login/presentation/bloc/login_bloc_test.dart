import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:samim/core/resources/data_state.dart';
import 'package:samim/features/login/data/models/country_model.dart';
import 'package:samim/features/login/data/models/user_model.dart';
import 'package:samim/features/login/domain/entities/country_entity.dart';
import 'package:samim/features/login/domain/entities/user_entity.dart';
import 'package:samim/features/login/domain/use_cases/get_countries_usecase.dart';
import 'package:samim/features/login/domain/use_cases/login_usecase.dart';
import 'package:samim/features/login/presentation/bloc/login_bloc.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([GetLoginUseCase, GetCountriesUseCase])
void main() {
  MockGetLoginUseCase mockGetLoginUseCase = MockGetLoginUseCase();
  MockGetCountriesUseCase mockGetCountriesUseCase = MockGetCountriesUseCase();
  List<UserEntity> userList = [
    const UserModel(username: "mina", email: "mina@gmail.com", state: "enable"),
    const UserModel(
        username: "arash", email: "arash@gmail.com", state: "disable"),
    const UserModel(
        username: "sara", email: "sara@gmail.com", state: "disable"),
    const UserModel(
        username: "milad", email: "milad@gmail.com", state: "enable"),
  ];

  group('test checking email users', () {
    test('emit Loading and Login Success state', () {
      String email = 'milad@gmail.com';
      String password = 'cscsFFDD';
      when(mockGetLoginUseCase.call(any))
          .thenAnswer((_) async => DataSuccess(userList));

      final bloc = LoginBloc(mockGetLoginUseCase, mockGetCountriesUseCase);
      bloc.add(LoginButtonPressed(
        email: email,
        password: password,
      ));

      expectLater(
        bloc.stream,
        emitsInOrder([
          LoginLoading(),
          const LoginSuccess(status: true),
        ]),
      );
    });

    test('emit Loading and Login Error state', () {
      String email = 'arash@gmail.com';
      String password = 'xssssssaaxDD';
      when(mockGetLoginUseCase.call(any))
          .thenAnswer((_) async => DataSuccess(userList));

      final bloc = LoginBloc(mockGetLoginUseCase, mockGetCountriesUseCase);
      bloc.add(LoginButtonPressed(
        email: email,
        password: password,
      ));

      expectLater(
        bloc.stream,
        emitsInOrder([
          LoginLoading(),
          const LoginSuccess(status: false),
        ]),
      );
    });
  });

  group('test get all countries', () {
    test('emit Loading and Login Success state', () {
      List<CountryEntity> counries = [
        const CountryModel(
            name: "Afghan afghani",
            alpha3Code: "AFG",
            capital: "Kabul",
            translations: {
              "br": "Afeganistão",
              "de": "Afghanistan",
              "es": "Afganistán",
              "fa": "افغانستان",
              "fr": "Afghanistan",
              "hr": "Afganistan",
              "it": "Afghanistan",
              "ja": "アフガニスタン",
              "nl": "Afghanistan",
              "pt": "Afeganistão",
              "ru": "Афганистан",
              "pl": "Afganistan",
              "cs": "Afgánistán",
              "zh": "阿富汗伊斯兰共和国",
              "hu": "Afganisztán",
              "se": "Afghanistan"
            }),
      ];
      when(mockGetCountriesUseCase.call(any))
          .thenAnswer((_) async => DataSuccess(counries));

      final bloc = LoginBloc(mockGetLoginUseCase, mockGetCountriesUseCase);
      bloc.add(GetCountries());

      expectLater(
        bloc.stream,
        emitsInOrder([
          GetCountryLoading(),
          GetCountrySuccess(data: counries),
        ]),
      );
    });
  });
}
