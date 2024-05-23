// ignore_for_file: unnecessary_const

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumpiapp/controllers/postController.dart';

import 'widgets/postDataWidget.dart';
import 'widgets/postFieldWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _postController.getAllPosts();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var username = box.read('username');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Rumpi App', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PostField(
                controller: _textController,
                hintText: 'Ada gosip apa hari ini?',
              ),
              _gap(),
              ElevatedButton(
                
                clipBehavior: Clip.none,
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: Colors.black54,
                  // padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size(100.0, 50.0),
                ),
                onPressed: () async {
                  await _postController.createPost(
                      content: _textController.text.trim());
                  _textController.clear();
                  _postController.getAllPosts();
                },
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Post',
                          style: TextStyle(color: Colors.white),
                        );
                }),
              ),
              _gap(),
              const Divider(
                color: Colors.black26,
                thickness: 1.0,
              ),
              _gap(),
              const Center(
                child: Text(
                  'Kabar gosip terbaru',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _gap(),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: _postController.posts.value.length,
                          itemBuilder: (context, index) {
                            return PostData(
                              post: _postController.posts.value[index],
                            );
                          },
                        ),
                    );
                // PostData();
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _gap() {
    return const SizedBox(
      height: 16.0,
    );
  }
}
