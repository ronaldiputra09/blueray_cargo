import 'dart:convert';

import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:blueray_cargo/app/services/dio_client.dart';
import 'package:blueray_cargo/app/widgets/dialog_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifikasiController extends GetxController {
  final dio = DioClient();
  var isLoading = false.obs;
  var codeC = TextEditingController().obs;
  var codeError = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> verify() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.VERIFY_CODE,
        options: Options(headers: {
          'AccessToken':
              'fe17d6c84394e37f804b614871f7fdf60b71f3685df902ee2b5cf59ba5b7da887158ce2702a0f7b2a9ad44e357af6c678bf1',
        }),
        data: {
          'user_id': email.value,
          'code': codeC.value.text,
        },
      );
      Get.offAllNamed('/profile', arguments: email.value);
    } catch (e) {
      var err = jsonDecode(e.toString());
      codeError.value = err['code'][0];
    } finally {
      isLoading(false);
    }
  }

  Future<void> resend() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.RESEND_CODE,
        options: Options(headers: {
          'AccessToken':
              'fe17d6c84394e37f804b614871f7fdf60b71f3685df902ee2b5cf59ba5b7da887158ce2702a0f7b2a9ad44e357af6c678bf1',
        }),
        data: {
          'user_id': email.value,
        },
      );
      dialogWidget(
        type: 'success',
        message: 'Kode verifikasi telah dikirim ulang',
      );
    } catch (e) {
      dialogWidget(type: 'error', message: 'Gagal mengirim ulang kode');
    } finally {
      isLoading(false);
    }
  }
}
