import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:infopessoas/core/services/internal_error_service.dart';

String identifyError({required dynamic error, required String message}) {
  String messageError = message;

  if (error is TimeoutException) {
    return 'Tempo esgotado.\nVerifique sua conexão com a internet.';
  }

  if (error is TypeError) {
    return 'Erro de tipo.';
  }

  if (error is DioException && error.error is SocketException) {
    return 'Sem conexão com a internet.\nVerifique sua rede.';
  }

  if (error is InternalErrorService) {
    messageError = error.message;
  }

  return messageError;
}
