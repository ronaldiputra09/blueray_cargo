import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:blueray_cargo/app/data/colors.dart';
import 'package:blueray_cargo/app/widgets/loading_widget.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? sizeLoading;
  final Color? colorLoading;
  final double? radius;
  final BoxFit? isFit;
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.sizeLoading,
    this.colorLoading,
    this.radius,
    this.isFit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$imageUrl",
      imageBuilder: (context, imageProvider) => Container(
        width: height ?? context.height,
        height: width ?? context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 100),
          image: DecorationImage(
            image: imageProvider,
            fit: isFit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height ?? context.height,
        width: width ?? context.width,
        child: LoadingWidget(
          size: sizeLoading ?? 20,
          color: colorLoading ?? primary,
        ),
      ),
      errorListener: (value) => log(value.toString()),
      errorWidget: (context, url, error) => Container(
        width: height ?? context.height,
        height: width ?? context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 100),
          image: const DecorationImage(
            image: NetworkImage(
                "https://ui-avatars.com/api/?name=e&background=231388&length=1&color=FFFFFF&bold=true"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
