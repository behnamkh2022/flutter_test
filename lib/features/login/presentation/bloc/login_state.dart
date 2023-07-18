part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final bool status;
  const LoginSuccess({required this.status});

  @override
  List<Object> get props => [status];
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}

// Events Get Countries
class GetCountryLoading extends LoginState {}

class GetCountrySuccess extends LoginState {
  final List<CountryEntity> data;
  const GetCountrySuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class GetCountryError extends LoginState {
  final String message;

  const GetCountryError({required this.message});

  @override
  List<Object> get props => [message];
}