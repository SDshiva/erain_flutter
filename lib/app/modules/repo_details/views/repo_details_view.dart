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
          repo.name.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
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
          backgroundColor: Colors.grey[200],
          child: ClipOval(
            child: Image.network(
              repo.owner.avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  controller.defaultAvatar,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Owner: ${repo.owner.login.toUpperCase()}",
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          repo.description.isEmpty
              ? "No description available."
              : repo.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Watchers: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              repo.watchers.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _updatedDateSection(Repo repo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Last Updated:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(
          controller.formatDate(repo.updatedAt),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
