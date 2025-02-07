import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/repo_details/bindings/repo_details_binding.dart';
import '../modules/repo_details/views/repo_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REPO_DETAILS,
      page: () => RepoDetailsView(),
      binding: RepoDetailsBinding(),
    ),
  ];
}
