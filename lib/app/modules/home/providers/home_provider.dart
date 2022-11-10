
import 'package:get/get.dart';

import '../../../data/models/product_model/product_model.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://fakestoreapi.com';
    httpClient.defaultDecoder = (list) =>
        List<ProductModel>.from(list.map((x) => ProductModel.fromJson(x)));
    // 请求拦截
    httpClient.addRequestModifier<void>((request) {
      // request.headers['Authorization'] = '12345678';
      return request;
    });

    // 响应拦截
    httpClient.addResponseModifier((request, response) {
      return response;
    });
  }

  Future<Response<List<ProductModel>>> getProducts() async =>
      await get('/products');
}
