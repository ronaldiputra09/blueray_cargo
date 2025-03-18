import 'dart:convert';

import 'package:blueray_cargo/app/services/api_path.dart';
import 'package:blueray_cargo/app/services/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final dio = DioClient();
  final box = GetStorage();

  var isLoading = false.obs;
  var isShow = true.obs;
  var emailC = TextEditingController().obs;
  var emailError = ''.obs;
  var passwordC = TextEditingController().obs;
  var passwordError = ''.obs;

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

  Future<void> login() async {
    isLoading(true);
    try {
      final res = await dio.post(
        ApiPath.LOGIN,
        data: {
          'user_id': emailC.value.text,
          'password': passwordC.value.text,
        },
      );
      var data = res.data;
      box.write('token', data['token']);
      Get.offAllNamed('/home');
    } catch (e) {
      var err = jsonDecode(e.toString());
      emailError(err['user_id'][0]);
      passwordError(err['password'][0]);
    } finally {
      isLoading(false);
    }
  }
}
