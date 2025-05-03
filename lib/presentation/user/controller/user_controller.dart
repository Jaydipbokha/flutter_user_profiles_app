import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;

import '../../../api/api_call.dart';
import '../../../utiles/db_helper.dart';
import '../model/user_model.dart';

enum LoadingStatus { loading, success, error }

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var address = ''.obs;

  bool isFetchUserLocations = true;

  bool isLoading = true;

  LoadingStatus status = LoadingStatus.loading;

  @override
  void onInit() async {
    super.onInit();
    await loadLocation();
    await loadUsers();
  }

  Future<void> loadUsers() async {
    status = LoadingStatus.loading;
    update(['userStatus']);
    users.clear();

    try {
      List<UserModel> localUsers = await DBHelper.getUsers();

      if (localUsers.isNotEmpty) {
        users.assignAll(localUsers);
        status = LoadingStatus.success;
        update(['userStatus']);
        return;
      }

  
      final response = await ApiCall.getApiCall(endPoint: 'users?page=2');

      if (response != null && response['data'] != null) {
        List data = response['data'];

        for (var item in data) {
          var user = UserModel.fromJson(item);
          await DBHelper.insertUser(user);
          users.add(user);
        }

        status = LoadingStatus.success;
      } else {
        status = LoadingStatus.error;
      }
    } catch (e) {
      print('Error: $e');
      status = LoadingStatus.error;
    }

    update(['userStatus']);
  }

  Future<void> loadLocation() async {
    loc.Location location = loc.Location();

    try {
    
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          address.value = 'Location services are disabled.';
          return;
        }
      }

     
      loc.PermissionStatus permission = await location.hasPermission();
      if (permission == loc.PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != loc.PermissionStatus.granted) {
          address.value = 'Location permission denied.';
          return;
        }
      }

      
      loc.LocationData locationData = await location.getLocation();

      
      List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);

    
      latitude.value = locationData.latitude.toString();
      longitude.value = locationData.longitude.toString();
      address.value =
          '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].country}';
      isFetchUserLocations = false;
      update(['isFetchLocation']);
    } catch (e) {
      address.value = 'Error: ${e.toString()}';
    }
  }

  Future<void> uploadImage(int userId, ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      await DBHelper.updateUserImage(userId, image.path);
      users[users.indexWhere((u) => u.id == userId)].localImagePath =
          image.path;
      users.refresh();
    }
  }
}
