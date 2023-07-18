import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

class MyAppbar extends StatefulWidget {
  final String title;
  const MyAppbar({super.key, required this.title});

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);
    return AppBar(
      actions: [
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            String? currentTheme = state.themeData ?? 'light';
            return IconButton(
              onPressed: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(SetTheme(key: 'theme', value: currentTheme));
              },
              icon: currentTheme == 'dark'
                  ? const Icon(
                      Icons.sunny,
                      color: Colors.amber,
                    )
                  : const Icon(
                      Icons.mode_night,
                      color: Colors.black,
                    ),
            );
          },
        ),
        BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
          return state.locale == 'en'
              ? TextButton(
                  onPressed: () {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(const SetLocale(key: 'locale', value: 'fa'));
                    const Locale.fromSubtags(languageCode: 'fa');
                  },
                  child: SizedBox(
                    width: 30,
                    height: 20,
                    child: SvgPicture.asset(
                      'assets/flags/irn.svg',
                      width: 30,
                      height: 20,
                    ),
                  ))
              : TextButton(
                  onPressed: () {
                    BlocProvider.of<SettingsBloc>(context)
                        .add(const SetLocale(key: 'locale', value: 'en'));
                    const Locale.fromSubtags(languageCode: 'en');
                  },
                  child: SizedBox(
                    width: 30,
                    height: 20,
                    child: SvgPicture.asset(
                      'assets/flags/usa.svg',
                      width: 30,
                      height: 20,
                    ),
                  ),
                );
        })
      ],
      automaticallyImplyLeading: false,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
