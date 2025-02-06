import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/github_services.dart';
import '../../../database/database_helper.dart';
import '../../../models/repo_model.dart';

class HomeController extends GetxController {
  final _githubService = GithubServices();
  final _databaseHelper = DatabaseHelper();
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
        await _databaseHelper.insertRepos(fetchedRepos);
        repos.addAll(fetchedRepos);
        pageCount.value++;
      }
    } catch (e) {
      // If API call fails, load repositories from the database
      final cachedRepos =
          await _databaseHelper.getPaginatedRepos(pageCount.value, 10);
      if (cachedRepos.isNotEmpty) {
        repos.addAll(cachedRepos);
        pageCount.value++;
      } else {
        Get.snackbar(
          "Error",
          "Check your internet connection and try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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

  // Helper function to format the date
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
