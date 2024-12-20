import 'package:base_project/core/type_def/api_response_data.dart';
import 'package:base_project/layers/domain/entities/activity_history_info_model.dart';

abstract class ActivityHistoryRepository {
  Future<ApiResponseData<List<ActivityHistoryInfoModel>?>> getActivityHistory();
}
