import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../local_storage/shared_preferences_manager.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final accessToken = PrefsManager.getData(key: "token") ?? "";
    options.headers["Authorization"] = 'Bearer $accessToken';
    log('accessToken: => $accessToken');
    super.onRequest(options, handler);
  }
}
