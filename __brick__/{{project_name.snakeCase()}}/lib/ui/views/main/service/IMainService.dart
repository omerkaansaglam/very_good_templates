import 'package:{{project_name.snakeCase()}}/core/managers/network_manager/model/api_result.dart';
import 'package:{{project_name.snakeCase()}}/ui/views/main/model/data.dart';

abstract class IMainService {
  Future<ApiResult<List<Data>>> fetchDatas();
}
