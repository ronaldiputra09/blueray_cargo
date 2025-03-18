import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future dialogWidget({
  String title = "Informasi",
  required String type,
  required String message,
  String textButton = "Baik",
  Function()? onPressed,
}) {
  return Get.defaultDialog(
    barrierDismissible: false,
    title: title,
    titleStyle: TextStyle(
      color: black,
      fontSize: 16,
      fontWeight: bold,
    ),
    titlePadding: const EdgeInsets.only(top: 20),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: type == "success"
                ? green.withOpacity(0.1)
                : type == "error"
                    ? red.withOpacity(0.1)
                    : yellow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            type == "success"
                ? Icons.check_circle_outline
                : type == "error"
                    ? Icons.error_outline
                    : Icons.info_outline,
            color: type == "success"
                ? green
                : type == "error"
                    ? red
                    : yellow,
            size: 50,
          ),
        ),
        Text(
          message,
          style: const TextStyle(
            color: black,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            type == 'info'
                ? Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: ButtonWidget(
                        title: "Batal",
                        color: Colors.grey,
                        onPressed: () => Get.back(),
                      ),
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: ButtonWidget(
                title: textButton,
                color: type == "success" || type == "info" ? primary : red,
                onPressed: onPressed ?? () => Get.back(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
