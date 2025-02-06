import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/github_services.dart';
import '../../../models/repo_model.dart';

class HomeController extends GetxController {
  final _githubService = GithubServices();
  final repos = <Repo>[].obs;
  final pageCount = 1.obs;
  final isLoading = true.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchRepos();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value) {
        loadMoreRepos();
      }
    });
    super.onInit();
  }

  Future<void> fetchRepos() async {
    try {
      isLoading(true);
      final fetchedRepos =
          await _githubService.fetchRepos('Android', pageCount.value);
      if (fetchedRepos.isNotEmpty) {
        repos.addAll(fetchedRepos);
        pageCount.value++;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch repositories: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void loadMoreRepos() {
    if (!isLoading.value) {
      fetchRepos();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
