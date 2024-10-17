import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../../common/utils/getit_utils.dart';
import '../../../../common/utils/logger.dart';
import '../../../domain/interfaces/theme_repository_interface.dart';

final themeProvider =
    AutoDisposeBlocProvider<ThemeCubit, ThemeMode>((_) => getIt<ThemeCubit>());

@singleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(
    this._repository,
  ) : super(_repository.getCurrentTheme());

  final IThemeRepository _repository;

  void setTheme(ThemeMode mode) async {
    try {
      await _repository.setTheme(mode);
      emit(mode);
    } catch (error) {
      logger.e(error);
    }
  }
}
