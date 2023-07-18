import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samim/core/resources/data_state.dart';
import 'package:samim/features/login/domain/entities/country_entity.dart';
import 'package:samim/features/login/domain/use_cases/login_usecase.dart';

import '../../../../core/usecase/use_case.dart';
import '../../domain/use_cases/get_countries_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoginUseCase getLoginUseCase;
  final GetCountriesUseCase getCountriesUseCase;
  LoginBloc(this.getLoginUseCase, this.getCountriesUseCase)
      : super(
          LoginInitial(),
        ) {
    on<GetCountries>((event, emit) async {
      emit(GetCountryLoading());
      DataState dataState = await getCountriesUseCase(NoParams());
      if (dataState is DataSuccess) {
        emit(GetCountrySuccess(data: dataState.data));
      }

      if (dataState is DataFailed) {
        emit(LoginError(message: dataState.error!));
      }
    });
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 3));
      Map<String, dynamic> param = {
        'email': event.email,
        'password': event.password,
      };
      DataState dataState = await getLoginUseCase(param);

      if (dataState is DataSuccess) {
        bool emailExists = dataState.data
            .any((user) => user.email == event.email && user.state == "enable");
        emit(LoginSuccess(status: emailExists));
      }

      if (dataState is DataFailed) {
        emit(LoginError(message: dataState.error!));
      }
    });
  }
}
