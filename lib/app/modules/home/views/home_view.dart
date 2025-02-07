import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Github Repositories",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            if (controller.isLoading.value && controller.repos.isEmpty) {
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
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final repo = controller.repos[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ), // Gap between cards
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.REPO_DETAILS, arguments: repo);
                    },
                    child: Card(
                      elevation: 4, // Add shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              repo.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                                height: 8), // Gap between title and description
                            Text(
                              repo.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    12), // Gap between description and owner info
                            Row(
                              children: [
                                const Icon(Icons.person,
                                    size: 16, color: Colors.blue),
                                const SizedBox(
                                    width: 8), // Gap between icon and text
                                Text(
                                  repo.owner.login.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                                height:
                                    8), // Gap between owner info and update date
                            Row(
                              children: [
                                const Icon(Icons.update,
                                    size: 16, color: Colors.green),
                                const SizedBox(
                                    width: 8), // Gap between icon and text
                                Text(
                                  "Last updated: ${controller.formatDate(repo.updatedAt)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
