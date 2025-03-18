import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/data/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(primary: primary),
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: white,
      surfaceTintColor: white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      titleSpacing: 0,
      titleTextStyle: primaryFont.copyWith(
        fontSize: 16.0,
        fontWeight: bold,
        color: black,
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: black,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: primaryFont.copyWith(
        fontSize: 96,
        fontWeight: semiBold,
        color: black,
      ),
      headlineMedium: primaryFont.copyWith(
        fontSize: 60,
        fontWeight: semiBold,
        color: black,
      ),
      headlineSmall: primaryFont.copyWith(
        fontSize: 48,
        fontWeight: regular,
        color: black,
      ),
      bodyLarge: primaryFont.copyWith(
        fontSize: 16,
        fontWeight: regular,
        color: black,
      ),
      bodyMedium: primaryFont.copyWith(
        fontSize: 14,
        fontWeight: regular,
        color: black,
      ),
      bodySmall: primaryFont.copyWith(
        fontSize: 12,
        fontWeight: regular,
        color: black,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerHeadlineStyle: primaryFont.copyWith(
        fontSize: 16.0,
        fontWeight: semiBold,
        color: black,
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: white,
      titleTextStyle: primaryFont.copyWith(
        fontSize: 16.0,
        fontWeight: semiBold,
        color: black,
      ),
      contentTextStyle: primaryFont.copyWith(
        fontSize: 14.0,
        fontWeight: regular,
        color: black,
      ),
    ),
  );
}
