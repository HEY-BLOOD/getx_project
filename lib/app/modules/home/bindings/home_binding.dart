import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:getx_project/app/data/network/client/dio_client.dart';
import 'package:getx_project/app/data/network/services/user_service.dart';
import 'package:getx_project/app/data/repositories/user_repository.dart';
import 'package:getx_project/app/modules/home/providers/home_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomeProvider>(
      () => HomeProvider(),
    );
    Get.lazyPut(() => DioClient(Dio()));
    Get.lazyPut(() => UserService(dioClient: Get.find<DioClient>()));
    Get.lazyPut(() => UserRepository(Get.find<UserService>()));
  }
}
