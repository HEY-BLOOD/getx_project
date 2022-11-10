import 'package:get/get.dart';

import 'package:getx_project/app/data/models/product_model/product_model.dart';
import 'package:getx_project/app/data/models/user_model.dart';
import 'package:getx_project/app/data/repositories/user_repository.dart';

import '../providers/home_provider.dart';

class HomeController extends GetxController
    with StateMixin<List<ProductModel>> {
  final provider = Get.find<HomeProvider>();
  final userRepository = Get.find<UserRepository>();

  final RxList users = RxList.empty();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchList();
    fetchUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // 处理接口返回的数据
  Future<void> fetchList() async {
    users.clear();
    // 获取数据
    final Response res = await provider.getProducts();

    // 判断，如果有错误
    if (res.hasError) {
      // 改变数据，传入错误状态，在ui中会处理这些错误
      change(null, status: RxStatus.error(res.statusText));
    } else {
      // 否则，存储数据，改变状态为成功
      change(res.body, status: RxStatus.success());
    }
  }

  Future<void> fetchUsers() async {
    users.clear();
    final List<UserModel> res = await userRepository.getUsersRequested();
    users.addAll(res);
  }
}
