import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumpiapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rumpiapp/models/postsModel.dart';

class PostController extends GetxController {
  Rx<List<PostsModel>> posts = Rx<List<PostsModel>>([]);

  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer '+ box.read('token'),
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        // print(json.decode(response.body));
        for (var item in json.decode(response.body)['feeds']) {
          posts.value.add(PostsModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer '+ box.read('token'),
        },
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Post created successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(response.body));
      }
      
    } catch (e) {
      
    }
  }
}
