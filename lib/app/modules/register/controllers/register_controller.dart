import 'dart:convert';

import 'package:blueray_cargo/app/modules/verifikasi/views/verifikasi_view.dart';
import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:blueray_cargo/app/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final dio = DioClient();
  var isLoading = false.obs;
  var emailC = TextEditingController().obs;
  var emailError = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> register() async {
    isLoading(true);
    try {
      await dio.post(
        ApiPath.REGISTER,
        options: Options(
          headers: {
            'AccessToken':
                'fe17d6c84394e37f804b614871f7fdf60b71f3685df902ee2b5cf59ba5b7da887158ce2702a0f7b2a9ad44e357af6c678bf1',
          },
        ),
        data: {
          'user_id': emailC.value.text,
        },
      );
      Get.to(() => VerifikasiView(), arguments: emailC.value.text);
    } catch (e) {
      var err = jsonDecode(e.toString());
      emailError(err['user_id'][0]);
    } finally {
      isLoading(false);
    }
  }
}
