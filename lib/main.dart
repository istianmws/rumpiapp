import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumpiapp/views/loginPage.dart';
import 'package:rumpiapp/views/registerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rumpi App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: LoginPage(),/*
      getPages: [
        GetPage(name: LoginPage.id, page: ()=> LoginPage()),
        GetPage(name: RegisterPage.id, page: ()=> RegisterPage())
      ],*/
    );
  }
}
