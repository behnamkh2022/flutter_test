import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences prefs;
  SettingsBloc(this.prefs) : super(SettingsState()) {
    on<SetLocale>((event, emit) async {
      setStore(
        event.key,
        event.value,
      );
      final theme = getStore('theme');
      emit(SettingsState(locale: event.value, themeData: theme));
    });

    on<GetLocale>((event, emit) async {
      final selectedLanguage = getStore(event.key);
      final theme = getStore('theme');
      emit(SettingsState(locale: selectedLanguage ?? 'fa', themeData: theme));
    });

    on<SetTheme>((event, emit) async {
      final theme = getStore(event.key);
      String newTheme = theme == 'light' ? 'dark' : 'light';
      setStore(
        event.key,
        newTheme,
      );
      final locale = getStore('locale');
      emit(SettingsState(themeData: newTheme, locale: locale));
    });

    on<GetTheme>((event, emit) async {
      final theme = getStore(event.key);
      final locale = getStore('locale');
      emit(SettingsState(themeData: theme ?? 'light', locale: locale));
    });
  }

  getStore(String key) {
    return prefs.getString(key);
  }

  setStore(String key, String value) {
    prefs.setString(
      key,
      value,
    );
    return value;
  }
}
