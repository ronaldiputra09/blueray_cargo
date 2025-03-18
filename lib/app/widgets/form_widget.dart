import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final bool? readOnly;
  final double? radius;
  final int? minLine;
  final int? maxLine;
  final Color? color;
  final bool capitalize;
  final bool required;
  final String? errorText;
  const FormWidget({
    super.key,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.readOnly,
    this.radius,
    this.minLine,
    this.maxLine,
    this.color,
    this.capitalize = false,
    this.required = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          replacement: const SizedBox(),
          child: Row(
            children: [
              Text(
                title ?? "",
                style: primaryFont.copyWith(
                  color: black,
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
              Visibility(
                visible: required,
                replacement: const SizedBox(),
                child: Text(
                  " *",
                  style: primaryFont.copyWith(
                    color: red,
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: title != null ? 7 : 0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textCapitalization: capitalize
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
                obscureText: obscureText ?? false,
                controller: controller,
                keyboardType: keyboardType,
                onChanged: onChanged,
                onTap: onTap,
                onFieldSubmitted: onFieldSubmitted,
                onEditingComplete: onEditingComplete,
                readOnly: readOnly ?? false,
                minLines: minLine ?? 1,
                maxLines: maxLine ?? 1,
                style: primaryFont.copyWith(
                  color: black,
                  fontSize: 14,
                  fontWeight: medium,
                ),
                decoration: InputDecoration(
                  hintText: hintText ?? "",
                  hintStyle: primaryFont.copyWith(
                    color: black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  isDense: true,
                  filled: true,
                  fillColor: color ?? bg,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 10),
                    ),
                    borderSide: BorderSide(
                      color: errorText != null && errorText != '' ? red : grey,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 10),
                    ),
                    borderSide: BorderSide(
                      color: errorText != null && errorText != '' ? red : grey,
                      width: 1.0,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 10),
                    ),
                    borderSide: BorderSide(
                      color: grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius ?? 10),
                    ),
                    borderSide: BorderSide(
                      color: primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: errorText != null && errorText != '',
          replacement: const SizedBox(),
          child: Text(
            errorText ?? "",
            style: primaryFont.copyWith(
              color: red,
              fontSize: 12,
              fontWeight: medium,
            ),
          ),
        ),
      ],
    );
  }
}
