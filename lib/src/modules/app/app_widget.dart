import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../generated/l10n.dart';
import '../../common/constants/constants.dart';
import '../../common/extensions/build_context_x.dart';
import '../../common/theme/app_theme.dart';
import '../../common/theme/app_theme_wrapper.dart';
import '../../common/utils/getit_utils.dart';
import '../../core/application/cubits/lang/lang_cubit.dart';
import '../../core/application/cubits/theme/theme_cubit.dart';
import 'app_router.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(langProvider);
    final themeMode = ref.watch(themeProvider);
    final router = getIt<AppRouter>();
    final talker = getIt<Talker>();
    final mode = themeMode == ThemeMode.system
        ? context.mediaQuery.platformBrightness == Brightness.light
            ? ThemeMode.light
            : ThemeMode.dark
        : themeMode;
    return ScreenUtilInit(
      designSize: Constants.defaultScreenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => AppThemeWrapper(
        key: ValueKey(locale),
        appTheme: AppTheme.create(context, locale, mode),
        builder: (BuildContext context, ThemeData themeData) {
          return MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            theme: themeData,
            routerConfig: router.config(
              navigatorObservers: () => [TalkerRouteObserver(talker)],
            ),
          );
        },
      ),
    );
  }
}
