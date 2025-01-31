import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../generated/l10n.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/extensions/locale_x.dart';
import '../../../../common/widgets/background_container.dart';
import '../../../../core/application/cubits/lang/lang_cubit.dart';
import '../../../../core/application/cubits/theme/theme_cubit.dart';

class SettingsBody extends ConsumerWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackgroundContainer(
      child: ListView(
        children: [
          _buildLanguageDropdown(context, ref),
          _buildThemeModeDropdown(context, ref),
          _buildVersionInfo(context, ref),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, WidgetRef ref) {
    final state = ref.watch(langProvider.bloc).state;
    return ListTile(
      title: Row(
        children: [
          Text(
            context.s.common_language,
            style: context.textTheme.titleMedium
                .copyWith(color: context.colorTheme.primaryText),
          ),
          const Spacer(),
          DropdownButton<Locale>(
            dropdownColor: context.colorTheme.primaryContainer,
            value: state,
            items: LocaleX.supportedLocales
                .map((locale) => DropdownMenuItem(
                      value: locale,
                      child: Text(
                        locale.languageName,
                        style: context.textTheme.titleMedium
                            .copyWith(color: context.colorTheme.primaryText),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              ref.read(langProvider.bloc).setLocale(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeModeDropdown(BuildContext context, WidgetRef ref) {
    final state = ref.watch(themeProvider.bloc).state;
    return ListTile(
      title: Row(
        children: [
          Text(
            context.s.setting_dark_mode,
            style: context.textTheme.titleMedium
                .copyWith(color: context.colorTheme.primaryText),
          ),
          const Spacer(),
          DropdownButton<ThemeMode>(
            dropdownColor: context.colorTheme.primaryContainer,
            value: state,
            items: ThemeMode.values
                .map((themeMode) => DropdownMenuItem(
                      value: themeMode,
                      child: Text(
                        context.s.themeMode(themeMode),
                        style: context.textTheme.titleMedium
                            .copyWith(color: context.colorTheme.primaryText),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              ref.read(themeProvider.bloc).setTheme(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final version = snapshot.data?.version;
            final buildNumber = snapshot.data?.buildNumber;

            if (version != null && buildNumber != null) {
              return Text(context.s.common_version('$version($buildNumber)'),
                  style: context.textTheme.titleSmall
                      .copyWith(color: context.colorTheme.primaryText));
            }
            return const SizedBox();
          }),
    );
  }
}

extension ThemeModeX on S {
  String themeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return setting_system;
      case ThemeMode.light:
        return setting_no;
      case ThemeMode.dark:
        return setting_yes;
    }
  }
}
