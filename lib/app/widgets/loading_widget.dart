import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:blueray_cargo/app/data/colors.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
  Color? color;
  double? size;
  LoadingWidget({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: color ?? white,
        size: size ?? 20,
      ),
    );
  }
}
