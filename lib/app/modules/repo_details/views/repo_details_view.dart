import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/repo_model.dart';
import '../controllers/repo_details_controller.dart';

class RepoDetailsView extends GetView<RepoDetailsController> {
  const RepoDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final Repo repo = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          repo.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ownerSection(repo),
            const SizedBox(height: 20),
            _repositoryDescription(repo),
            const SizedBox(height: 20),
            _updatedDateSection(repo),
          ],
        ),
      ),
    );
  }

  Widget _ownerSection(Repo repo) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(repo.owner.avatarUrl),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Owner: ${repo.owner.login}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "GitHub Contributor",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _repositoryDescription(Repo repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Repository Description:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          repo.description.isEmpty
              ? "No description available."
              : repo.description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _updatedDateSection(Repo repo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Last Updated:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          controller.formatDate(repo.updatedAt),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
