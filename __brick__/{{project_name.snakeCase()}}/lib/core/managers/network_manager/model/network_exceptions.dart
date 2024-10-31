import 'package:dio/dio.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/network_manager/model/api_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled(ApiError error) =
      RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(ApiError error) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest(ApiError error) = BadRequest;

  const factory NetworkExceptions.notFound(ApiError error) = NotFound;

  const factory NetworkExceptions.methodNotAllowed(ApiError error) =
      MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable(ApiError error) = NotAcceptable;

  const factory NetworkExceptions.requestTimeout(ApiError error) =
      RequestTimeout;

  const factory NetworkExceptions.sendTimeout(ApiError error) = SendTimeout;

  const factory NetworkExceptions.conflict(ApiError error) = Conflict;

  const factory NetworkExceptions.internalServerError(ApiError error) =
      InternalServerError;

  const factory NetworkExceptions.notImplemented(ApiError error) =
      NotImplemented;

  const factory NetworkExceptions.serviceUnavailable(ApiError error) =
      ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection(ApiError error) =
      NoInternetConnection;

  const factory NetworkExceptions.formatException(ApiError error) =
      FormatException;

  const factory NetworkExceptions.unableToProcess(ApiError error) =
      UnableToProcess;

  const factory NetworkExceptions.defaultError(ApiError error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.socialError({String? message}) = SocialError;

  static NetworkExceptions handleResponse(Response? response) {
    ApiError? errorModel;

    try {
      errorModel = ApiError.fromJson(response?.data).copyWith(
        statusCode: response?.statusCode,
      );
    } catch (e) {
      return const NetworkExceptions.unexpectedError();
    }

    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(errorModel);
      case 404:
        return NetworkExceptions.notFound(errorModel);
      case 409:
        return NetworkExceptions.conflict(errorModel);
      case 408:
        return NetworkExceptions.requestTimeout(errorModel);
      case 422:
        return NetworkExceptions.defaultError(errorModel);
      case 500:
        return NetworkExceptions.internalServerError(errorModel);
      case 503:
        return NetworkExceptions.serviceUnavailable(errorModel);
      default:
        return NetworkExceptions.defaultError(errorModel);
    }
  }

  static NetworkExceptions getDioException(error) {
    return error.when(
      cancel: () =>
          const RequestCancelled(ApiError(message: 'Request Cancelled')),
      connectTimeout: () =>
          const RequestTimeout(ApiError(message: 'Connection Timeout')),
      sendTimeout: () => const SendTimeout(ApiError(message: 'Send Timeout')),
      receiveTimeout: () =>
          const RequestTimeout(ApiError(message: 'Receive Timeout')),
      response: (error) => handleResponse(error.response),
      request: (error) => BadRequest(ApiError(message: error.message)),
      socket: () => const NoInternetConnection(
          ApiError(message: 'No Internet Connection')),
      defaultError: (error) => DefaultError(ApiError(message: error.message)),
    );
  }
}

extension NetworkExceptionExtension on NetworkExceptions {
  String get errorMessage =>
      when(
        badRequest: (error) => error.message,
        notFound: (error) => error.message,
        methodNotAllowed: (error) => error.message,
        notAcceptable: (error) => error.message,
        requestTimeout: (error) => error.message,
        sendTimeout: (error) => error.message,
        conflict: (error) => error.message,
        internalServerError: (error) => error.message,
        notImplemented: (error) => error.message,
        serviceUnavailable: (error) => error.message,
        noInternetConnection: (error) => error.message,
        formatException: (error) => error.message,
        unableToProcess: (error) => error.message,
        defaultError: (error) => error.message,
        unexpectedError: () => 'Unexpected Error',
        requestCancelled: (error) => error.message,
        unauthorizedRequest: (error) => error.message,
        socialError: (message) => message ?? '',
      ) ??
      'Unexpected Error';
}
