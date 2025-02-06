import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Repositories"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.repos.isEmpty) {
                  return const Center(child: Text("No Repositories Found"));
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.repos.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.repos.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final repo = controller.repos[index];
                    return Card(
                      child: ListTile(
                        title: Text(repo.name),
                        subtitle: Text(repo.description),
                      ),
                    );
                  },
                );
              },
            )),
      ),
    );
  }
}
