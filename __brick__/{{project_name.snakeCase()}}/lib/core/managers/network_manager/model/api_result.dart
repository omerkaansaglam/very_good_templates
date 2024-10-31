import 'package:dio/dio.dart';
import 'package:faladdin_flutterapp/core/managers/network_manager/model/network_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const ApiResult._();

  factory ApiResult.success([T? value]) = Success<T>;

  const factory ApiResult.failure(NetworkExceptions error) = Failure<T>;

  T get data => maybeWhen(
        success: (data) => data ?? {} as T,
        orElse: () => throw Exception("No data available"),
      );
}

extension ResultMessageExtension on Response<dynamic> {
  static const String kSuccessMessage = 'message';

  String get message {
    return data[kSuccessMessage] ?? '';
  }
}

extension ApiResultExtension<T> on ApiResult<T> {
  static const String kAuthPhoneKey = 'phone';
  static const String kAuthEmailKey = 'email';
  static const String kAuthFirstNameKey = 'first_name';
  static const String kAuthLastNameKey = 'last_name';

  String get errorMessage => (this as Failure<T>).error.errorMessage;

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  bool get isPhone => (this as Failure<T>).error.maybeWhen(
      orElse: () => false,
      defaultError: (error) => error.errors[kAuthPhoneKey] != null);

  bool get isEmail => (this as Failure<T>).error.maybeWhen(
      orElse: () => false,
      defaultError: (error) => error.errors[kAuthEmailKey] != null);

  bool get isFirstName => (this as Failure<T>).error.maybeWhen(
      orElse: () => false,
      defaultError: (error) => error.errors[kAuthFirstNameKey] != null);

  bool get isLastName => (this as Failure<T>).error.maybeWhen(
      orElse: () => false,
      defaultError: (error) => error.errors[kAuthLastNameKey] != null);
}
