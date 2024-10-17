import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';

import 'src/common/extensions/locale_x.dart';
import 'src/common/utils/app_environment.dart';
import 'src/common/utils/getit_utils.dart';
import 'src/common/utils/logger.dart';
import 'src/core/domain/interfaces/lang_repository_interface.dart';
import 'src/core/infrastructure/datasources/local/storage.dart';
import 'src/modules/app/app_widget.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await AppEnvironment.setup();
    await Storage.setup();
    await GetItUtils.setup();

    const platform = MethodChannel('base.mode/navigation-mode');
    int mode = 2; // Full screen gesture mode
    if (Platform.isAndroid) {
      try {
        // support read the android navigation mode only.
        mode = await platform.invokeMethod('getNavigationMode');
      } on PlatformException catch (_) {}
    }
    if (mode == 2) SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    final langRepository = getIt<ILangRepository>();
    final talker = getIt<Talker>();
    _setupErrorHooks(talker);
    logger.d(
        'deviceLocale - ${langRepository.getDeviceLocale().fullLanguageCode}');
    logger.d('currentLocale - ${langRepository.getLocale().fullLanguageCode}');

    runApp(
      ProviderScope(
        observers: [TalkerRiverpodObserver(talker: talker)],
        child: BottomNavigationModeRegion(
          mode: mode,
          child: const AppWidget(),
        ),
      ),
    );
  }, (error, stack) {
    getIt<Talker>().handle(error, stack);
  });
}

Future _setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _reportError(details.exception, details.stack, talker);
    };
  }
  PlatformDispatcher.instance.onError = (error, stack) {
    _reportError(error, stack, talker);
    return true;
  };

  /// Web doesn't have Isolate error listener support
  if (!kIsWeb) {
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      final isolateError = pair as List<dynamic>;
      _reportError(
        isolateError.first.toString(),
        isolateError.last.toString(),
        talker,
      );
    }).sendPort);
  }
}

void _reportError(dynamic error, dynamic stackTrace, Talker talker) async {
  talker.error('Unhandled Exception', error, stackTrace);
}

class BottomNavigationModeRegion extends InheritedWidget {
  const BottomNavigationModeRegion({
    super.key,
    required this.mode,
    required super.child,
  });

  final int mode;

  @override
  bool updateShouldNotify(covariant BottomNavigationModeRegion oldWidget) {
    return oldWidget.mode == mode;
  }

  static BottomNavigationModeRegion? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BottomNavigationModeRegion>();
  }

  static int of(BuildContext context) {
    final BottomNavigationModeRegion? result = maybeOf(context);
    return result?.mode ?? 2;
  }
}
