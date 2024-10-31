import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ApiError({
    int? statusCode,
    String? message,
    dynamic errors,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
