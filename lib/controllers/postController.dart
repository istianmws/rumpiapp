import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumpiapp/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rumpiapp/models/commentsModel.dart';
import 'package:rumpiapp/models/postsModel.dart';

class PostController extends GetxController {
  Rx<List<PostsModel>> posts = Rx<List<PostsModel>>([]);
  Rx<List<CommentsModel>> comments = Rx<List<CommentsModel>>([]);

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
        'Authorization': 'Bearer ' + box.read('token'),
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
          'Authorization': 'Bearer ' + box.read('token'),
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
    } catch (e) {}
  }

  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;
      var response =
          await http.get(Uri.parse('${url}feed/comments/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + box.read('token'),
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        for (var item in json.decode(response.body)['comments']) {
          comments.value.add(CommentsModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {}
  }

  Future createComment(id, body) async {
    try {
      isLoading.value = true;
      var data = {
        'body': body,
      };
      var request = await http.post(Uri.parse('${url}feed/comment/$id'),
          headers: {
            'Accept': 'application',
            'Authorization': 'Bearer ' + box.read('token'),
          },
          body: data);
      if (request.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar(
          'Success',
          'Comment created successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(request.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(request.body));
      }
    } catch (e) {}
  }

  Future likePost(id) async {
    try {
      isLoading.value = true;
      var request = await http.post(Uri.parse('${url}feed/like/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + box.read('token'),
      });

      if (request.statusCode == 200){
        var post = posts.value.firstWhere((post) => post.id == id);
        post.liked = !post.liked!;
        posts.refresh();
        if(json.decode(request.body)['message'] == 'like success'){
          Get.snackbar(
            'Success',
            'Post liked successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Success',
            'Gosipnya overrated',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        isLoading.value = false;
        
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(request.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(json.decode(request.body));
      }

    } catch (e) {}
  }
}
