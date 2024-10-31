import 'package:faladdin_flutterapp/core/managers/network_manager/model/api_result.dart';
import 'package:faladdin_flutterapp/ui/views/main/model/data.dart';

abstract class IMainService {
  Future<ApiResult<List<Data>>> fetchDatas();
}
