import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:getx_project/constants/app_constants.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Client>(() => Client()
      ..setEndpoint(AppConstans.appwriteEndpoint)
      ..setProject(AppConstans.appwriteProjectId));
    Get.lazyPut<Account>(
      () => Account(Get.find<Client>()),
    );
  }
}
