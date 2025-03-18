import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/verifikasi_controller.dart';

class VerifikasiView extends GetView<VerifikasiController> {
  VerifikasiView({super.key});
  final verifikasiC = Get.put(VerifikasiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            body(),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          bottom: false,
          child: Text(
            'Verifikasi',
            style: TextStyle(
              fontSize: 28,
              fontWeight: bold,
            ),
          ),
        ),
        Text(
          'Silahkan masukan kode verifikasi yang telah dikirim ke',
          style: TextStyle(
            color: black.withOpacity(0.5),
          ),
        ),
        Text(
          verifikasiC.email.value,
          style: TextStyle(
            color: primary,
          ),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Pinput(
            length: 6,
            controller: verifikasiC.codeC.value,
            keyboardType: TextInputType.text,
            defaultPinTheme: PinTheme(
              textStyle: TextStyle(
                fontSize: 24,
                color: black,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: grey,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(10),
              height: 60,
              width: 50,
            ),
            focusedPinTheme: PinTheme(
              textStyle: TextStyle(
                fontSize: 24,
                color: black,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: primary,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.all(10),
              height: 60,
              width: 50,
            ),
          ),
          Obx(
            () => Visibility(
              visible: verifikasiC.codeError.value != '',
              replacement: const SizedBox(),
              child: Text(
                verifikasiC.codeError.value,
                style: primaryFont.copyWith(
                  color: red,
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Obx(
            () => ButtonWidget(
              title: 'Masukan Kode',
              loading: verifikasiC.isLoading.value,
              onPressed: () {
                if (verifikasiC.isLoading.isFalse) {
                  verifikasiC.verify();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tidak menerima kode verifikasi?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black.withOpacity(0.5),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (verifikasiC.isLoading.isFalse) {
                verifikasiC.resend();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(
                'Kirim ulang kode',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
