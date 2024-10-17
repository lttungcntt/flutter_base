// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_base/src/common/theme/color_theme/default_dart_color_theme.dart'
    as _i959;
import 'package:flutter_base/src/common/theme/color_theme/default_light_color_theme.dart'
    as _i119;
import 'package:flutter_base/src/common/theme/text_theme/default_text_theme.dart'
    as _i241;
import 'package:flutter_base/src/common/utils/logger.dart' as _i880;
import 'package:flutter_base/src/core/application/cubits/auth/auth_cubit.dart'
    as _i9;
import 'package:flutter_base/src/core/application/cubits/lang/lang_cubit.dart'
    as _i847;
import 'package:flutter_base/src/core/application/cubits/theme/theme_cubit.dart'
    as _i278;
import 'package:flutter_base/src/core/domain/interfaces/lang_repository_interface.dart'
    as _i404;
import 'package:flutter_base/src/core/domain/interfaces/theme_repository_interface.dart'
    as _i572;
import 'package:flutter_base/src/core/infrastructure/datasources/remote/api/api_client.dart'
    as _i594;
import 'package:flutter_base/src/core/infrastructure/datasources/remote/api/services/auth/auth_client.dart'
    as _i655;
import 'package:flutter_base/src/core/infrastructure/repositories/lang_repository.dart'
    as _i992;
import 'package:flutter_base/src/core/infrastructure/repositories/theme_repository.dart'
    as _i400;
import 'package:flutter_base/src/modules/app/app_router.dart' as _i12;
import 'package:flutter_base/src/modules/auth/domain/interfaces/auth_repository_interface.dart'
    as _i656;
import 'package:flutter_base/src/modules/auth/infrastructure/repositories/auth_repository.dart'
    as _i631;
import 'package:flutter_base/src/modules/dashboard/application/cubit/dashboard_cubit.dart'
    as _i280;
import 'package:flutter_base/src/modules/dashboard/domain/interfaces/dashboard_interface.dart'
    as _i638;
import 'package:flutter_base/src/modules/dashboard/infrastructure/repositories/dashboard_mockup_repository.dart'
    as _i571;
import 'package:flutter_base/src/modules/dashboard/infrastructure/repositories/dashboard_repository.dart'
    as _i1028;
import 'package:flutter_base/src/modules/home/application/cubit/home_cubit.dart'
    as _i794;
import 'package:flutter_base/src/modules/home/domain/interfaces/home_interface.dart'
    as _i784;
import 'package:flutter_base/src/modules/home/infrastructure/repositories/home_mockup_repository.dart'
    as _i173;
import 'package:flutter_base/src/modules/home/infrastructure/repositories/home_repository.dart'
    as _i1054;
import 'package:flutter_base/src/modules/home_detail/application/cubit/home_detail_cubit.dart'
    as _i336;
import 'package:flutter_base/src/modules/home_detail/domain/interfaces/home_detail_interface.dart'
    as _i228;
import 'package:flutter_base/src/modules/home_detail/infrastructure/repositories/home_detail_mockup_repository.dart'
    as _i672;
import 'package:flutter_base/src/modules/home_detail/infrastructure/repositories/home_detail_repository.dart'
    as _i380;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

const String _ALPHA = 'ALPHA';
const String _DEV = 'DEV';
const String _PRG = 'PRG';
const String _UAT = 'UAT';
const String _PRD = 'PRD';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    final apiModule = _$ApiModule();
    gh.singleton<_i207.Talker>(() => loggerModule.talker());
    gh.singleton<_i241.DefaultTextTheme>(() => _i241.DefaultTextTheme());
    gh.singleton<_i959.DefaultDarkColorTheme>(
        () => _i959.DefaultDarkColorTheme());
    gh.singleton<_i119.DefaultLightColorTheme>(
        () => _i119.DefaultLightColorTheme());
    gh.singleton<_i12.AppRouter>(() => _i12.AppRouter());
    gh.lazySingleton<_i638.IDashboardRepository>(
      () => _i571.DashboardMockupRepository(),
      registerFor: {_ALPHA},
    );
    gh.lazySingleton<_i228.IHomeDetailRepository>(
      () => _i672.HomeDetailMockupRepository(),
      registerFor: {_ALPHA},
    );
    gh.lazySingleton<_i784.IHomeRepository>(
      () => _i173.HomeMockupRepository(),
      registerFor: {_ALPHA},
    );
    gh.factory<_i336.HomeDetailCubit>(
        () => _i336.HomeDetailCubit(gh<_i228.IHomeDetailRepository>()));
    gh.factory<String>(
      () => apiModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i404.ILangRepository>(() => _i992.LangRepository());
    gh.singleton<_i361.Dio>(() => apiModule.dio(
          gh<String>(instanceName: 'baseUrl'),
          gh<_i404.ILangRepository>(),
          gh<_i207.Talker>(),
        ));
    gh.singleton<_i280.DashboardCubit>(
        () => _i280.DashboardCubit(gh<_i638.IDashboardRepository>()));
    gh.lazySingleton<_i572.IThemeRepository>(() => _i400.ThemeRepository());
    gh.lazySingleton<_i638.IDashboardRepository>(
      () => _i1028.DashboardRepository(),
      registerFor: {
        _DEV,
        _PRG,
        _UAT,
        _PRD,
      },
    );
    gh.lazySingleton<_i784.IHomeRepository>(
      () => _i1054.HomeRepository(),
      registerFor: {
        _DEV,
        _PRG,
        _UAT,
        _PRD,
      },
    );
    gh.lazySingleton<_i228.IHomeDetailRepository>(
      () => _i380.HomeDetailRepository(),
      registerFor: {
        _DEV,
        _PRG,
        _UAT,
        _PRD,
      },
    );
    gh.singleton<_i278.ThemeCubit>(
        () => _i278.ThemeCubit(gh<_i572.IThemeRepository>()));
    gh.singleton<_i847.LangCubit>(
        () => _i847.LangCubit(gh<_i992.LangRepository>()));
    gh.factory<_i794.HomeCubit>(
        () => _i794.HomeCubit(gh<_i784.IHomeRepository>()));
    gh.factory<_i655.AuthClient>(() => _i655.AuthClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i656.IAuthRepository>(
        () => _i631.AuthRepository(gh<_i655.AuthClient>()));
    gh.singleton<_i9.AuthCubit>(
        () => _i9.AuthCubit(gh<_i656.IAuthRepository>()));
    return this;
  }
}

class _$LoggerModule extends _i880.LoggerModule {}

class _$ApiModule extends _i594.ApiModule {}
