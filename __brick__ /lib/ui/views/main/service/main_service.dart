import 'package:{{project_name.snakeCase()}}/core/managers/network_manager/model/api_result.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/network_manager/model/network_exceptions.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/network_manager/network_manager.dart';
import 'package:{{project_name.snakeCase()}}/ui/views/main/model/data.dart';
import 'package:{{project_name.snakeCase()}}/ui/views/main/service/IMainService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainServiceProvider = Provider<IMainService>(_MainService.new);

class _MainService implements IMainService {
  final Ref ref;
  final String path = 'todos';

  _MainService(this.ref);
  @override
  Future<ApiResult<List<Data>>> fetchDatas() async {
    try {
      final response = await ref.read(networkManagerProvider).get(path);
      final result = response.data as List<dynamic>;
      return ApiResult.success(result.map((e) => Data.fromJson(e)).toList());
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
