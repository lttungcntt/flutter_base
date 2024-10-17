part of '../pages/auth_page.dart';

class AuthBody extends HookConsumerWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    final emilController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Container(
      color: ColorName.background,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 16.0,
                    children: [
                      Assets.images.welcome.image(),
                      EmailWidget(
                        emailTextEditingController: emilController,
                        errorText: state.whenOrNull<String?>(
                          error: (error) => error.whenOrNull(
                            invalidEmail: () =>
                                context.s.common_error_invalid_email,
                          ),
                        ),
                      ),
                      PasswordWidget(
                        passwordTextEditingController: passwordController,
                        errorText: state.whenOrNull<String?>(
                          error: (error) => error.whenOrNull(
                            invalidPassword: () =>
                                context.s.common_error_invalid_password,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text(context.s.common_login),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ref.read(authProvider.bloc).login(
                                LoginRequest(
                                  email: emilController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state == const AuthState.loading())
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),
    );
  }
}
