part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  String? locale = 'fa';
  String? themeData = 'light';
  SettingsState({this.locale, this.themeData});

  @override
  List<Object?> get props => [locale, themeData];
}