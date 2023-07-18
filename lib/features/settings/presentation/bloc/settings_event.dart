part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SetLocale extends SettingsEvent {
  final String key;
  final String value;
  const SetLocale({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}

class GetLocale extends SettingsEvent {
  final String key;
  const GetLocale({required this.key});

  @override
  List<Object> get props => [key];
}

class SetTheme extends SettingsEvent {
  final String key;
  final String value;
  const SetTheme({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}

class GetTheme extends SettingsEvent {
  final String key;
  const GetTheme({required this.key});

  @override
  List<Object> get props => [key];
}