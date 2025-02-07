import 'package:get/get.dart';

import '../../../utilities/assets_manager.dart';

class RepoDetailsController extends GetxController {
  final defaultAvatar = AssetsManager.defaultAvatar;
  String formatDate(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}-${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
  }
}
