import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumpiapp/views/loginPage.dart';
import 'package:rumpiapp/views/registerPage.dart';

Future<void> main() async {
  
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
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
      ),
    );
  }
}
