import 'package:auto_route/annotations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../../generated/colors.gen.dart';
import '../../../../common/extensions/build_context_dialog.dart';
import '../../../../common/extensions/build_context_x.dart';
import '../../../../common/utils/logger.dart';
import '../../../../core/application/cubits/auth/auth_cubit.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';

part '../widgets/auth_body.dart';
part '../widgets/email_widget.dart';
part '../widgets/password_widget.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (_, now) {
      now.whenOrNull(
        authenticated: (user) {
          logger.d('User: $user');
        },
        error: (error) {
          error.whenOrNull(
            other: (message) => context.showError(message),
          );
        },
      );
    });
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: const AuthBody(),
      ),
    );
  }
}
