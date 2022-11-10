import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:getx_project/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model/product_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'.tr),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Icon(Icons.settings),
            onTap: () => Get.toNamed(Routes.SETTINGS),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Center(
        child: controller.obx(
          (state) => ListView.separated(
              itemBuilder: (context, index) {
                final ProductModel product = state![index];
                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: ValueKey(index),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    // dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) => onSharePressed(context),
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        // flex: 2,
                        onPressed: (context) {},
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'Archive',
                      ),
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Save',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: ListTile(
                        onTap: () => Get.toNamed(Routes.DETAIL),
                        leading:
                            // SizedBox(
                            //   width: 80,
                            //   child: BlurHash(
                            //     hash: 'L5H2EC=PM+yV0g-mq.wG9c010J}I',
                            //     image: product.image!,
                            //     imageFit: BoxFit.scaleDown,
                            //   ),
                            // ),

                            CachedNetworkImage(
                          imageUrl: product.image!,
                          width: 80,
                          fit: BoxFit.scaleDown,
                          placeholder: (context, url) =>
                              Container(color: Colors.purple[100]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(
                          maxLines: 1,
                          product.title!,
                          overflow: TextOverflow.fade,
                        ),
                        subtitle: Text(
                          product.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state!.length),
          onError: (err) => Text("$err"),
          onLoading: Text(
            "loading".tr,
            style: const TextStyle(color: Colors.blue, fontSize: 16),
          ),
          onEmpty: const Text("empty list"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () async {
          // use dio client
          await controller.fetchUsers();
        },
      ),
    );
  }

  void onSharePressed(BuildContext context) {
    Share.share(
      'check out my website https://example.com',
      subject: 'Look what I made!',
    );
  }
}
