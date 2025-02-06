import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../models/repo_model.dart';

class GithubServices {
  static const String baseUrl = 'https://api.github.com';

  Future<List<Repo>> fetchRepos({String platform = "android"}) async {
    final response = await http
        .get(Uri.parse('$baseUrl/search//repositories?q=language:$platform'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log("This is to see the response: $data");
      return (data['items'] as List).map((e) => Repo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load repos');
    }
  }
}
