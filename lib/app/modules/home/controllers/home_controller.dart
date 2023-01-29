import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:streamdeck/app/utils/function_utils.dart';

import '../../../helpers/functionality.dart';

class HomeController extends GetxController {
  late Socket socket;

  var ip = '192.168.0.2';
  var port = '6969';
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void onReady() {
    super.onReady();
    initialFunction();
  }

  @override
  void onClose() {
    socket.close();
    socket.close();
  }

  Future<void> initialFunction() async {
    dialogLoading();
    await connectSocket(ip: ip, port: port);
    Get.back();
  }

  Future<void> connectSocket({required String ip, required String port}) async {
    try {
      socket = await Socket.connect(ip, int.parse(port));
      socket.listen((event) {
        logKey('socket listen', event);
      });
      socket.write("st_start");
    } catch (e) {
      logKey('error connect socket', e.toString());
    }
  }

  void hideSource({required currentFunction, required bool isActivate, required additinalData}) {
    if (currentFunction == Functionality.hideSource) {
      if (!isActivate) {
        socket.write('s_hide$additinalData');
      } else {
        socket.write('s_unhide$additinalData');
      }
    }
  }

  void switchScene({required int sceneNumber}) {
    socket.write('scene${sceneNumber}');
  }
}
