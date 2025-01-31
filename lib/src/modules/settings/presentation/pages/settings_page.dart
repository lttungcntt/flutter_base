import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/widgets/common_appbar.dart';
import '../widgets/settings_body.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: context.s.common_settings, context: context),
      body: const SettingsBody(),
    );
  }
}
