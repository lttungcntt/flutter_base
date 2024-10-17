import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:enum_annotation/enum_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../../common/mixin/cancelable_base_bloc.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../domain/entities/home_detail.dart';
import '../../domain/interfaces/home_detail_interface.dart';

part 'home_detail_state.dart';
part 'home_detail_cubit.freezed.dart';
part 'home_detail_cubit.g.dart';

final homeDetailProvider =
    BlocProvider<HomeDetailCubit, HomeDetailState>((_) => getIt<HomeDetailCubit>());

@injectable
class HomeDetailCubit extends Cubit<HomeDetailState> with CancelableBaseBloc {
  final IHomeDetailRepository _repository;
  HomeDetailCubit(this._repository) : super(const HomeDetailState()) {
    get();
  }

  get() async {
    emit(state.loading);
    final response = await _repository.getById(1, token: cancelToken);
    response.fold(
      (result) => emit(state.onLoaded(result)),
      (error) => emit(state.onError(error)),
    );
  }
}