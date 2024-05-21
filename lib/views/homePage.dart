// ignore_for_file: unnecessary_const

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'widgets/postDataWidget.dart';
import 'widgets/postFieldWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var username = box.read('username');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rumpi App', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PostField(
                  controller: _postController,
                  hintText: 'Ada gosip apa hari ini?',
                ),
                _gap(),
                ElevatedButton(
                  clipBehavior: Clip.none,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    // padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    minimumSize: const Size(100.0, 50.0),
                  ),
                  onPressed: () {
                    print(_postController.text);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                _gap(),
                const Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
                _gap(),
                _gap(),
                const Text(
                  'Gosip hari ini',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _gap(),
                
                const PostData(),
                const PostData(),
                const PostData(),
              ],
            ),
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
