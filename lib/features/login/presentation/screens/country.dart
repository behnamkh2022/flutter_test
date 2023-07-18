import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/mediaquery.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/login_bloc.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late bool isTablet;
  late bool isDesktop;
  late int crossAxisCount;
  late double itemHeight;
  late double itemWidth;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SettingsBloc>(context);
    var appLocalizations = AppLocalizations.of(context);
    isTablet = kWidth(context) >= 600;
    isDesktop = kWidth(context) >= 1024;

    crossAxisCount = isDesktop
        ? 5
        : isTablet
            ? 4
            : 2;
    itemHeight = isDesktop
        ? 180.0
        : isTablet
            ? 150.0
            : 120.0;
    itemWidth = kWidth(context) / crossAxisCount;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppbar(title: appLocalizations!.countryList),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetCountryLoading) {
            return _buildLoadingUI();
          } else if (state is GetCountrySuccess) {
            return _buildLoadedUI(state.data, bloc.state.locale!, context);
          } else if (state is GetCountryError) {
            return _buildErrorUI();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildLoadingUI() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildShimmerEffect();
      },
    );
  }

  Widget _buildLoadedUI(
      List<CountryEntity> countries, String locale, BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        shrinkWrap: true, // Allow GridView to take only the necessary space.
        physics: const NeverScrollableScrollPhysics(),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          String name = locale == 'fa'
              ? country.translations!['fa'].toString()
              : country.name.toString();
          return InkWell(
            onTap: () {},
            child: Container(
              width: itemWidth,
              height: itemHeight,
              margin: const EdgeInsets.all(2.0),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      width: 60,
                      height: 40,
                      child: SvgPicture.asset(
                        'assets/flags/${country.alpha3Code.toString().toLowerCase()}.svg',
                        width: 60,
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(name),
                  Text(country.capital.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorUI() {
    return const Center(
      child: Text('Error occurred while fetching data.'),
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      shrinkWrap: true, // Allow GridView to take only the necessary space.
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          width: itemWidth,
          height: itemHeight,
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: ColorManager.grey,
                highlightColor: ColorManager.light,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: 40.0,
                    width: 60.0,
                    color: ColorManager.light,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Shimmer.fromColors(
                baseColor: ColorManager.grey,
                highlightColor: ColorManager.light,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    color: ColorManager.light,
                    height: 16.0,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Shimmer.fromColors(
                baseColor: ColorManager.grey,
                highlightColor: ColorManager.light,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    color: ColorManager.light,
                    height: 16.0,
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
