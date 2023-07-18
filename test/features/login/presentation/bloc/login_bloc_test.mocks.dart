// Mocks generated by Mockito 5.4.2 from annotations
// in samim/test/features/login/presentation/bloc/login_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:samim/core/resources/data_state.dart' as _i3;
import 'package:samim/core/usecase/use_case.dart' as _i10;
import 'package:samim/features/login/domain/entities/country_entity.dart'
    as _i9;
import 'package:samim/features/login/domain/entities/user_entity.dart' as _i7;
import 'package:samim/features/login/domain/repository/country_repository.dart'
    as _i4;
import 'package:samim/features/login/domain/repository/login_repository.dart'
    as _i2;
import 'package:samim/features/login/domain/use_cases/get_countries_usecase.dart'
    as _i8;
import 'package:samim/features/login/domain/use_cases/login_usecase.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserRepository_0 extends _i1.SmartFake
    implements _i2.UserRepository {
  _FakeUserRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDataState_1<T> extends _i1.SmartFake implements _i3.DataState<T> {
  _FakeDataState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCountryRepository_2 extends _i1.SmartFake
    implements _i4.CountryRepository {
  _FakeCountryRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetLoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLoginUseCase extends _i1.Mock implements _i5.GetLoginUseCase {
  MockGetLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserRepository get loginBaseRepository => (super.noSuchMethod(
        Invocation.getter(#loginBaseRepository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#loginBaseRepository),
        ),
      ) as _i2.UserRepository);
  @override
  _i6.Future<_i3.DataState<List<_i7.UserEntity>>> call(Object? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i6.Future<_i3.DataState<List<_i7.UserEntity>>>.value(
            _FakeDataState_1<List<_i7.UserEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.DataState<List<_i7.UserEntity>>>);
}

/// A class which mocks [GetCountriesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCountriesUseCase extends _i1.Mock
    implements _i8.GetCountriesUseCase {
  MockGetCountriesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.CountryRepository get countryRepository => (super.noSuchMethod(
        Invocation.getter(#countryRepository),
        returnValue: _FakeCountryRepository_2(
          this,
          Invocation.getter(#countryRepository),
        ),
      ) as _i4.CountryRepository);
  @override
  _i6.Future<_i3.DataState<List<_i9.CountryEntity>>> call(
          _i10.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i6.Future<_i3.DataState<List<_i9.CountryEntity>>>.value(
            _FakeDataState_1<List<_i9.CountryEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i6.Future<_i3.DataState<List<_i9.CountryEntity>>>);
}