import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/repo_model.dart';

class GithubServices {
  static const String baseUrl = 'https://api.github.com';

  Future<List<Repo>> fetchRepos(String platform, int page) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/search/repositories?q=$platform&page=$page&per_page=10&sort=stars&order=desc'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List).map((e) => Repo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load repos');
    }
  }
}
