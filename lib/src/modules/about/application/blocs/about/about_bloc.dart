import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../../../common/utils/getit_utils.dart';

part 'about_bloc.freezed.dart';
part 'about_event.dart';
part 'about_state.dart';

final aboutProvider = AutoDisposeBlocProvider<AboutBloc, AboutState>((_) {
  return getIt<AboutBloc>();
});

@injectable
class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(const _StateHide()) {
    on<AboutEvent>((event, emit) => emit(
          event.when(
            show: () => const _StateShow(),
            hide: () => const _StateHide(),
          ),
        ));
  }
}
