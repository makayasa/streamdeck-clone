import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamdeck/app/components/default_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            controller.disconnectSocket();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.connectSocket(ip: controller.ip, port: controller.port);
            },
            icon: Icon(Icons.connected_tv),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.playSound();
        },
      ),
      body: Container(
        child: GridView.builder(
          shrinkWrap: true,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 5,
          //   crossAxisSpacing: 1,
          //   mainAxisSpacing: 1,
          // ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // maxCrossAxisExtent: 5.2,
            maxCrossAxisExtent: 100,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.switchScene(sceneNumber: index);
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: Center(
                  child: DefText('$index').normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
