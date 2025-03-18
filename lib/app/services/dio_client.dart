// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
// import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class DioClient {
  final box = GetStorage();
  final Dio _dio = Dio();

  DioClient() {
    _dio.options.baseUrl = ApiPath.BASE_URL;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    // _dio.options.receiveTimeout = Duration(seconds: 10);
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    // _dio.interceptors.add(
    //   CertificatePinningInterceptor(
    //     allowedSHAFingerprints: [
    //       '25:1C:50:CD:91:F8:BD:93:09:48:FF:CD:F0:ED:57:A1:61:16:5B:F1:01:06:DC:EA:CD:DD:63:30:38:DF:FF:C4'
    //     ],
    //     timeout: 10,
    //   ),
    // );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      final error = e.type;
      if (error == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      } else if (error == DioExceptionType.receiveTimeout) {
        throw 'Receive Timeout';
      } else if (error == DioExceptionType.badResponse) {
        throw _handleError(
          e.response?.statusCode,
          e.response?.data,
        );
      } else if (error == DioExceptionType.connectionError) {
        throw 'Tidak ada koneksi internet';
      } else if (error == DioExceptionType.cancel) {
        throw 'Request Cancelled';
      } else if (error == DioExceptionType.unknown) {
        throw 'No Internet Connection';
      } else {
        throw 'Connection Error';
      }
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      final error = e.type;
      if (error == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      } else if (error == DioExceptionType.receiveTimeout) {
        throw 'Receive Timeout';
      } else if (error == DioExceptionType.badResponse) {
        throw _handleError(
          e.response?.statusCode,
          e.response?.data,
        );
      } else if (error == DioExceptionType.connectionError) {
        throw 'Tidak ada koneksi internet';
      } else if (error == DioExceptionType.cancel) {
        throw 'Request Cancelled';
      } else if (error == DioExceptionType.unknown) {
        throw 'No Internet Connection';
      } else {
        throw 'Connection Error';
      }
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException catch (e) {
      final error = e.type;
      if (error == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      } else if (error == DioExceptionType.receiveTimeout) {
        throw 'Receive Timeout';
      } else if (error == DioExceptionType.badResponse) {
        throw _handleError(
          e.response?.statusCode,
          e.response?.data,
        );
      } else if (error == DioExceptionType.connectionError) {
        throw 'Tidak ada koneksi internet';
      } else if (error == DioExceptionType.cancel) {
        throw 'Request Cancelled';
      } else if (error == DioExceptionType.unknown) {
        throw 'No Internet Connection';
      } else {
        throw 'Connection Error';
      }
    }
  }

  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException catch (e) {
      final error = e.type;
      if (error == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      } else if (error == DioExceptionType.receiveTimeout) {
        throw 'Receive Timeout';
      } else if (error == DioExceptionType.badResponse) {
        throw _handleError(
          e.response?.statusCode,
          e.response?.data,
        );
      } else if (error == DioExceptionType.connectionError) {
        throw 'Tidak ada koneksi internet';
      } else if (error == DioExceptionType.cancel) {
        throw 'Request Cancelled';
      } else if (error == DioExceptionType.unknown) {
        throw 'No Internet Connection';
      } else {
        throw 'Connection Error';
      }
    }
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      final error = e.type;
      if (error == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      } else if (error == DioExceptionType.receiveTimeout) {
        throw 'Receive Timeout';
      } else if (error == DioExceptionType.badResponse) {
        throw _handleError(
          e.response?.statusCode,
          e.response?.data,
        );
      } else if (error == DioExceptionType.cancel) {
        throw 'Request Cancelled';
      } else if (error == DioExceptionType.connectionError) {
        throw 'Tidak ada koneksi internet';
      } else if (error == DioExceptionType.unknown) {
        throw 'No Internet Connection';
      } else {
        throw 'Connection Error';
      }
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        var err = jsonEncode(error);
        return err;
      case 401:
        return '${error['message']} $statusCode';
      case 403:
        return '${error['message']} $statusCode';
      case 404:
        return '${error['message']} $statusCode';
      case 409:
        return '${error['message']} $statusCode';
      case 422:
        return '${error['message']} $statusCode';
      case 500:
        return '${error['message']} $statusCode';
      // return 'Jaringan bermasalah';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }
}
