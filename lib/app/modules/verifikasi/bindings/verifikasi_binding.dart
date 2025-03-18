import 'package:get/get.dart';

import '../controllers/verifikasi_controller.dart';

class VerifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifikasiController>(
      () => VerifikasiController(),
    );
  }
}
