import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:blueray_cargo/app/widgets/loading_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final BorderSide? borderSide;
  final bool? loading;
  const ButtonWidget({
    super.key,
    this.title,
    this.onPressed,
    this.color,
    this.textColor,
    this.radius,
    this.borderSide,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        side: borderSide ?? BorderSide.none,
        backgroundColor: color ?? primary,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        fixedSize: Size.fromWidth(Get.width),
      ),
      child: loading == false
          ? Text(
              title ?? "",
              style: primaryFont.copyWith(
                color: textColor ?? white,
                fontSize: 14,
                fontWeight: semiBold,
              ),
            )
          : LoadingWidget(color: textColor ?? white),
    );
  }
}
