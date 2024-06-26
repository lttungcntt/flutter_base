import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/interfaces/home_interface.dart';
import '../../../../common/utils/app_environment.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../domain/entities/home.dart';
@LazySingleton(
  as: IHomeRepository,
  env: AppEnvironment.environments,
)
class HomeRepository implements IHomeRepository {
  @override
  Future<Result<List<IHome>,ApiError>> get({CancelToken? token}) async {
    // TODO: implement getById
    throw UnimplementedError();
  }
}