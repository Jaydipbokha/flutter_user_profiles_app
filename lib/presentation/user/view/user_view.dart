import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/utiles/color.dart';
import 'package:test_project/utiles/assets.dart';
import 'package:test_project/widget/text_widget.dart';
import 'package:test_project/widget/custom_app_bar.dart';
import '../../../utiles/string.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';

class UserListView extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppBar(
        title: AppStrings.userListTitle,
      ),
      body: GetBuilder<UserController>(
        id: 'userStatus',
        builder: (controller) {
          switch (controller.status) {
            case LoadingStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case LoadingStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppStrings.loadUsersError),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => controller.loadUsers(),
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              );

            case LoadingStatus.success:
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      stTitle: AppStrings.currentLocationTitle,
                      stFontSize: 18,
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<UserController>(
                      id: 'isFetchLocation',
                      builder: (controller) {
                        if (controller.isFetchUserLocations) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.grey100,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image(
                                    image: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/1865/1865269.png'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      stTitle:
                                          '${AppStrings.address}${controller.address.value}',
                                      stMaxLine: 2,
                                    ),
                                    CustomText(
                                      stTitle:
                                          '${AppStrings.latitude}${controller.latitude.value}',
                                    ),
                                    CustomText(
                                      stTitle:
                                          '${AppStrings.longitude}${controller.longitude.value}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      stTitle: AppStrings.userTitle,
                      stFontSize: 18,
                    ),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) {
                            UserModel user = controller.users[index];
                            return Card(
                              color: AppColors.whiteColor,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: user.localImagePath != null
                                    ? CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(user.localImagePath!),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.avatarUrl),
                                      ),
                                title: Text(user.firstName),
                                subtitle: Text(user.email),
                                trailing: IconButton(
                                  icon: const Icon(Icons.upload),
                                  onPressed: () =>
                                      showUploadDialog(context, user.id),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  void showUploadDialog(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: const Text(AppStrings.uploadImage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text(AppStrings.camera),
              onTap: () {
                controller.uploadImage(userId, ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text(AppStrings.gallery),
              onTap: () {
                controller.uploadImage(userId, ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
