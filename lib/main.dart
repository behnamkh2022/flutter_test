import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:samim/features/login/presentation/bloc/login_bloc.dart';
import 'package:samim/features/login/presentation/screens/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/utils/theme_data.dart';
import 'core/utils/enums.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => locator<LoginBloc>()),
        BlocProvider(create: (BuildContext context) => locator<SettingsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(const GetLocale(key: 'locale'));
    BlocProvider.of<SettingsBloc>(context).add(const GetTheme(key: 'theme'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        Locale locale = Locale(state.locale ?? 'fa');
        return MaterialApp(
          title: 'samim',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: state.themeData == 'dark'
              ? appThemeData[AppTheme.darkTheme]
              : appThemeData[AppTheme.lightTheme],
          home: const LoginForm(),
        );
      },
    );
  }
}
