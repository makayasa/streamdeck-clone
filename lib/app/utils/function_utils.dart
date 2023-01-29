import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constant.dart';

void logKey([key, content]) {
  String finalLog = '';
  dynamic tempContent = content ?? key;
  if (tempContent is Map || tempContent is List) {
    try {
      finalLog = json.encode(tempContent);
    } catch (e) {
      finalLog = tempContent.toString();
    }
  } else if (tempContent is String) {
    finalLog = tempContent;
  } else {
    finalLog = tempContent.toString();
  }

  if (content != null) {
    dev.log('$key => $finalLog');
  } else {
    dev.log(finalLog);
  }
}

Widget loading({double? size}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: (size ?? 50) * 2,
          width: (size ?? 50) * 2,
          // color: kBgWhite,
          child: Center(
            child: SpinKitFoldingCube(
              size: size ?? 50,
              color: kBgBlack,
            ),
          ),
        ),
      ],
    ),
  );
}

void dialogLoading({double? size}) {
  Get.dialog(
    loading(size: size),
    barrierDismissible: false,
  );
}
