import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:samim/core/utils/constants/colors.dart';
import 'package:samim/core/utils/helpers.dart';
import 'package:samim/features/login/presentation/bloc/login_bloc.dart';
import 'package:samim/features/login/presentation/screens/country.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/mediaquery.dart';
import '../../../../core/widgets/appbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FToast fToast = FToast();

  String errorTextEmail = '';
  String errorTextPassword = '';
  bool statusPassword = false;
  bool statusEmail = false;

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: ColorManager.orangeDark,
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: ColorManager.light),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            text,
            style: const TextStyle(color: ColorManager.light),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);
    final isTablet = kWidth(context) >= 600;
    final isDesktop = kWidth(context) >= 1024;
    final formWidth = isDesktop
        ? 400.0
        : isTablet
            ? 300.0
            : 200.0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppbar(title: appLocalizations!.login),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.status) {
              BlocProvider.of<LoginBloc>(context).add(GetCountries());
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CountryListScreen()),
              );
            } else {
              _showToast(appLocalizations.warningLogin);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SvgPicture.asset(
                            'assets/images/logo.svg',
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        appLocalizations.samim,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: appLocalizations.email,
                            labelStyle: const TextStyle(
                              fontSize: 16.0,
                              color: ColorManager.grey,
                            ),
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.grey, width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: errorTextEmail != ''
                                    ? ColorManager.orangeDark
                                    : ColorManager.grey,
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 15, top: 15, right: 15),
                            errorText:
                                errorTextEmail != '' ? errorTextEmail : null,
                            errorStyle: TextStyle(
                                color: errorTextEmail != ''
                                    ? Colors.red
                                    : Colors.grey),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (!Helpers.validateEmail(value)) {
                                errorTextEmail = appLocalizations.emailNotValid;
                                statusEmail = false;
                              } else {
                                errorTextEmail = '';
                                statusEmail = true;
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: appLocalizations.password,
                            labelStyle: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                            prefixIcon:
                                const Icon(Icons.lock_outlined, weight: 1.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: ColorManager.grey, width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: errorTextPassword != ''
                                    ? ColorManager.orangeDark
                                    : ColorManager.grey,
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 15, top: 15, right: 15),
                            errorText: errorTextPassword != ''
                                ? errorTextPassword
                                : null,
                            errorStyle: TextStyle(
                                color: errorTextPassword != ''
                                    ? ColorManager.orangeDark
                                    : ColorManager.grey),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
                                errorTextPassword = appLocalizations.passLatin;
                                statusPassword = false;
                              } else if (!value.contains(RegExp(r'[A-Z]')) ||
                                  !value.contains(RegExp(r'[a-z]'))) {
                                errorTextPassword =
                                    appLocalizations.passUpperLower;
                                statusPassword = false;
                              } else if (value.length < 8) {
                                errorTextPassword = appLocalizations.pass8;
                                statusPassword = false;
                              } else {
                                errorTextPassword = '';
                                statusPassword = true;
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: statusPassword && statusEmail
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.orangeDark,
                                  elevation: 5,
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: state is LoginLoading
                                    ? null
                                    : () async {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      },
                                child: state is LoginLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1.0,
                                        ),
                                      )
                                    : Text(
                                        appLocalizations.login,
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ColorManager.grey.withOpacity(0.5),
                                  elevation: 5,
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: null,
                                child: Text(
                                  appLocalizations.login,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
